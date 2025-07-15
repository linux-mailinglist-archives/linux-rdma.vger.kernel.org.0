Return-Path: <linux-rdma+bounces-12191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB95B05AA8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FB27A6D1A
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2040274FDB;
	Tue, 15 Jul 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ss2W9n6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2C165F13
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583998; cv=fail; b=AdJIfjkFO0bDnzeGKGWVMIKw6VH/wWAesaCMP4TqtmpEnyDzCEVBKPRJU1eRUm+slVerBaoTg4ZDCHjVqWaDCG1aaDb48ZCtmliOP1QvUoHnpXP1wRcymQxp4zC4errU6eyBBtfPg5RI2fBalKYkC9SgjXfWCC8HoZgTtChbHro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583998; c=relaxed/simple;
	bh=Z7+3uD1C71wtMevPvPzIhfpNP6gDgHWApcUAYU04Mts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Em3RHA0Sr9NQ2qhVjOtC+vNGhXrD2zsemItIinRnaKFYoSee+VLexQQeAsGDGIh1Ciz3EICcuqGqWDeTolP2mKwRwqzMy/ooVCFppyFKOZQ75NpHPNKxsZEpv0HDobkMlkLY8gmIlW7we5DJd8lssDlBNjDyPSKETBZT7y0EktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ss2W9n6j; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en/JLzh9lvPb+X7xwVyuVd/J6QscgYJvB+7AguhyK4DoOeUr4FhIddOeYNe9XTcixTLzr2/0SQ01FisPonGwe19Xby1MUMKSRgYlnbjk4piwO/jr1SMp+Wm3IT7iLQW+2lYKKF8oWlQkJtXsQvBnX5Xlr+FstL00qFVpXBY0nixibvmgS0foFVpofyahr0tAYJqZGWqI1UPZg25uaOyrBUl0P5uXdTJ0zXJ27bz1OK0Stqo6Merh5RMubVNyVlDsFKIWzRlN93w8ar0TUn5Jus14/ywCIpOjbceMTnUierxeMVEkiQOi9Xagins5DZ+SluPl7i3KlK4OR1vsjHBCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZCwUxNg/HmX5roBezm2F6HF2rrc8fCTlJhqYEI9etA=;
 b=ugh1Kby3+zL/+ehgklsLbjvf1mnALCTEFvTE4I/07YRlVkPfVRIBYHlMCpdtSSsBuB+AJK/OaMv7KxxHAdXYARnu5eoSGK0DhXtVqpNiNErHxTe4CC1ItS9Q4wRw+POVQpdTzC9TffrIV6QQ01faMHNZSFbVXoeGRWTqFMbYA9y4v/fxAnbTqWpp0ghl8pZJFqYJtVUh+jNhizEhpSAOe4dLmNHPNH7b21/7ljQLKzMsBnKdUouvOcLUACawYNFFZHKGg0efi2junznwRViLTHpEJneSanuAoq+sSkcBqkTqzsrtlsVL3Ozf/ZnmWTd9/tZachAHAhRzDcbiiG42cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZCwUxNg/HmX5roBezm2F6HF2rrc8fCTlJhqYEI9etA=;
 b=ss2W9n6jztxjBucVQEz0EHe8ljXbsPz0jxMhbv6tfB0dwv4NlMgscgAxf7hM0dR+Y3ZpPMuiJVDkfNDKvR/BYh8CVvGTGQFJ8HF9A42LbjEB5bE0W3xtkXbVl7MkhvkCPwhT+Eq2WdZcI3rfUT/lA7E5pJXZlrGD/bcTRy8Qaleu6lEOfW4GjU+J2JwjXt5eEpDCoyCNJRKu3khFlHeke51gs1uQZB/VRJrUqGHAFjwRQZGOPzKn+mpv7IcjlyfjyFomzxx8DQvEQ0N/76ktigWBy/6G/qeOQfbn/NJE24hMN9pJduP8qpzBSb1RvPkWbO/kGwYjE5pL6T4dYyLH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 12:53:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 12:53:12 +0000
Date: Tue, 15 Jul 2025 09:53:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Message-ID: <20250715125311.GL2067380@nvidia.com>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
 <20250714163925.GF2067380@nvidia.com>
 <01b087d1-8710-4111-8ba0-b942f77a8b0e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b087d1-8710-4111-8ba0-b942f77a8b0e@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: dba6dc39-731e-4ab8-75d4-08ddc39e8ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nm6E4HBoHP6YcrtTmj3jZlX/Os6yzcq5JkSmBDTBCWiMBRVPBr7GiHmtLRiY?=
 =?us-ascii?Q?fKxVfP4/cJkN+DNkN9i9e9u+xiTK+rRAlrxWts8r0OLsVDZLRhdMRAhCR+Lw?=
 =?us-ascii?Q?YUTisAOsPNtUMfJhVWjQMlSDrC78xghQanbJ12w2BpSYbtB4jknXzj+8lEBj?=
 =?us-ascii?Q?gNXFyiCFVdeDs7EgUNhTFIVCMMvXgaJ6wRVNhGSQVbFcpGAH/ZqdTu/tVbdC?=
 =?us-ascii?Q?r8BZdwIQ9y8VMY2VYX62acGOeBJ5x6U0VkcHJaIv5rwp2p7aTwi9AOUDHS45?=
 =?us-ascii?Q?QYa0JuopF0CpzktVmtql26HHs1Sh+LiUPDMpMhwDF7P+IrX9BEAB7n8zfZjI?=
 =?us-ascii?Q?e8CMuq9oUk6rrS3KTymk/c7EIldglRobbbz/sWfJkgjJnuRyVio6L9i3ZQKo?=
 =?us-ascii?Q?sz3I3NjtzO9ZZ7XoLUigMz1aRVng+XinoH1b7M5QhiP+equ5Z41gBlnvOMG3?=
 =?us-ascii?Q?bWdUwonGG6yiGCJscgSnBFEai5OJzsg5lfCs896bVvnijbPowMdFhyf6mo5/?=
 =?us-ascii?Q?8bqoldx2aYYM6/X5NE4XBAwZjZKyMRcX+8OWFCJufj0PJU3y7HbE4/N2eGjt?=
 =?us-ascii?Q?PkO5LfiqAjob42TuwuW5yrjV7EeL5AO/VlbSHV6PQpWnVigabIdscnJEpBtg?=
 =?us-ascii?Q?fghclDoDAFuh1IXnQTuFeVEe4a/WUuHhF+RXUKRKa1bkBM3+KUcY1HUve+XM?=
 =?us-ascii?Q?CrzVHcC6u2YHmPkcpArEwCqIkCt1JFS5kPE7G96dcDvUDi35JTq3jOIlPG5p?=
 =?us-ascii?Q?Ns+KSMLgkBeQyeS9aClXt0q0GCM7zmNBUJColh2frz53fu+/hfd46Jf7ogTt?=
 =?us-ascii?Q?gVMoPCFITQERCrPr0UCkNm5IFM7jLkdlKPC54Yr9wS7i03PU9gImil1LFxZb?=
 =?us-ascii?Q?gWKiS16Iy0rgTYTmxL8VJk5ZNkKKj2WDvFInEEk+8oQ0SNpgYrMWdO0TBTPn?=
 =?us-ascii?Q?bvv3Ho5qk7WmOBCf1ED/c91dB7eMGPpEdnrdmdiRB3UaOJJOY292KHgNQ4uv?=
 =?us-ascii?Q?1TUWQWCPGTdYiKbwpMbzhilzQJ5XuNMrPYFNTMTXBdJJEHMEoiWBYSbXfwwL?=
 =?us-ascii?Q?gxQ4cGNNdDG3bF1GnUYtjB2nUzP9kSERFs0TYvSniteDA4bEu2fR/mzXwmMx?=
 =?us-ascii?Q?qcWL99PrCruo0rFU1z2KYDCB9CABgIVmsGaUkka63pXQdy4hoPkJU0rQr+i6?=
 =?us-ascii?Q?fPtopbaUMXq+qM1CMtsfEW5Pix6Fu8/h5ffMM4ni/XbEYXApC88o8/sRfZEC?=
 =?us-ascii?Q?ksPjYbpPSUehXTJwdVXuZMHzJIlK1Gtjm3Fgtn6+eWYdXIzfxCexQ1ATa/WK?=
 =?us-ascii?Q?D20bK61mZ0UZB/uk8vfC4VZ93BfenogC0dmOQPWok8jFTwLMbUUaf5CnRNUH?=
 =?us-ascii?Q?AMfRGqu1w87F7GctJpjrnhQgsGdLquQHHMyRaYqY8huc1o4kX5GNSe6BD09M?=
 =?us-ascii?Q?6JiJeV9kNHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHALQolUbZnsjBHLmGS0rB1Fg/QKblL/oqxzzp5FnMuykNP/X56ehTb7p9gZ?=
 =?us-ascii?Q?OTW2v+5vHk6rBKiQ9px7G41Q9b0VNEd2AWqc+2VSALm6Tz77YcJrvOobq68f?=
 =?us-ascii?Q?k3H88zaRXY+E0lL7FWpjZVuL8POAo/Fv/XevkOLlLuAkXlfaqdaCtiRuBaHR?=
 =?us-ascii?Q?tKEVVuGYut6AI3o8iC1Ls66NOqN8lh50rOOEpPu6no9aw33czt75vv3Jv5Di?=
 =?us-ascii?Q?uMsDmxAZ+mQqnA6bgQAtw5jt+Ox3fIehf5VDS6ZNb/MHdQ50cdhWu5ROIrHu?=
 =?us-ascii?Q?jX18EFJO5K3cKeovJmbN8cyRuMVsOzL8X66z5v/toNqY1HWkgn9myo0FbErc?=
 =?us-ascii?Q?KfxWFCqLQRlk7Oke1poffJuyePlV38O3foE2Rex02ATnatEFvgsORsJd3mej?=
 =?us-ascii?Q?cjixBp3gxn40GcpzW3984y3S1YNGCl6Ojv5sJT7CxsuKtxlWYBrp/w9wjbyY?=
 =?us-ascii?Q?KGR/Rwm+u8wthrzSFmoawKIzJN934IV9jN2qGz9s2AXLvXDGana5qIj2v23T?=
 =?us-ascii?Q?taSwOJLcmv9hQDkPeW+ksGIQ83pIFQ0G/uCP+c9miw89cbwMYXHVfIzjtrxU?=
 =?us-ascii?Q?AE5IE8GPTMbLzJxxTp92V09LFlwlvFCUCTnhMXZj/JpGmv+Pyua5JOsQ8zpt?=
 =?us-ascii?Q?YYIGBkQy8DJVEduAY3VDVHEI6n27SmyoOvS7glK/jKg8wZFXi6XAAnk1JlcK?=
 =?us-ascii?Q?PfDGsQn0mh/FxLAfQoOKgldrNEinvKNMdyiUcuDc1MReGDuQTgZU4zM84Ov2?=
 =?us-ascii?Q?JEXNGEses+rUm9jbfcb4uVO9xxuApRcua0xK1+82S0RmVh9MFxy6UAkqT4sY?=
 =?us-ascii?Q?W+Gkxam+/bw7Ozy89T+xjwu8bAHqAXSkKWQDICNaDMhQv0/6se5VByEC4+oL?=
 =?us-ascii?Q?LGsDqIUsLmFY5Yvny6n2YTZQR131/a3ADDcpdQluurKS09Wi1YhUkJuDM8+m?=
 =?us-ascii?Q?0GqsZlt933iO2QR3V4ZFfb/qewimJqYZhvLySwVH/p9BwuO+Heh6ukgdzw9x?=
 =?us-ascii?Q?bezDpIjIMLdvw6KY9M41kLoIR5cj8LaHnrLqtOGtsl0/pxbanEj1/MxhpSbv?=
 =?us-ascii?Q?vXKdC8J3bDSNvxMtRfm0ov/l+PWhYU1BYFDmTVU26QXGekgjQUeTWUHT2kMT?=
 =?us-ascii?Q?GGhNiCs+q0eUVFl91ecpqBFiE7CAnh/EIo6Rsxa2jsFWhijZdyFliEu9SzHL?=
 =?us-ascii?Q?4dtQtpICJOX1hQ16M75BSYOlj73mk4tVP13REB8xrMmbwB34T3GUmSUjECts?=
 =?us-ascii?Q?TBc0Y7+ILYZ1YQphyancRx8CmItiEIyl4ks+KJrNtV16xBrIz/CfYF8bzUe3?=
 =?us-ascii?Q?LYU7wbw4Irt1j5QMehT/iopY7f+143i7oDD9x7o8pst5E1DAHcHwBT642hV2?=
 =?us-ascii?Q?gR0hKHwJyf8W4FxG2xjG4skDsdczym0y3KFuaTWxJso6vQtjurQhiW4oqFLx?=
 =?us-ascii?Q?Fl5Zm3sB0OZG3TJ1lT/M8G4DDiKJfqM51yVRuR7WKLkH7fqSfKlVR7Vl6B9F?=
 =?us-ascii?Q?nFt7+5t7S6ywlditt7OS2e9HgWCr8DcQRkyYKzX3LDA74Prb+abzG6UXIN+B?=
 =?us-ascii?Q?QEHv6pCup3rZQWKpgiHwa2HT+dnNRrwIiZ5gbM6c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba6dc39-731e-4ab8-75d4-08ddc39e8ecd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:53:12.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfCU/0C1NkofvgAlC0Ol8kffXvNCgsdjXBrFrA+8JX+/i2nQQe+8qiMRNldjLikV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169

On Tue, Jul 15, 2025 at 11:21:14AM +0300, Yishai Hadas wrote:
> On 14/07/2025 19:39, Jason Gunthorpe wrote:
> > On Sun, Jul 13, 2025 at 09:37:26AM +0300, Leon Romanovsky wrote:
> > > +static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
> > > +	struct uverbs_attr_bundle *attrs)
> > > +{
> > > +	struct ib_uobject *uobj =
> > > +		uverbs_attr_get(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE)
> > > +			->obj_attr.uobject;
> > > +	struct ib_device *ib_dev = attrs->context->device;
> > > +	struct ib_dmah *dmah;
> > > +	int ret;
> > > +
> > > +	if (!ib_dev->ops.alloc_dmah || !ib_dev->ops.dealloc_dmah)
> > > +		return -EOPNOTSUPP;
> > 
> > This shouldn't be needed, use UAPI_DEF_OBJ_NEEDS_FN() instead.
> 
> We already have UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah) below, so the check for
> !ib_dev->ops.dealloc_dmah can be dropped.

Fix both

> > > +DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,
> > > +			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_dmah),
> > > +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_ALLOC),
> > > +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_FREE));
> > > +
> > > +const struct uapi_definition uverbs_def_obj_dmah[] = {
> > > +	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
> > > +				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
> > > +	{}
> > 
> > I think it should be on the NAMED_OBJECT in this case, like AH:
> > 
> > 	DECLARE_UVERBS_OBJECT(
> > 		UVERBS_OBJECT_AH,
> > [..]
> > 		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
> > 		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
> > 
> 
> The NAMED_OBJECT doesn't support UAPI_DEF_OBJ_NEEDS_FN.

Hmm, really? I don't remember.

Jason

