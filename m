Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACB269A3D4
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBQCXX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQCXX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 21:23:23 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048244DE23
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 18:23:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0roLwZEIej3VJ+3kW5NUYZhH6VUfSsiMGijvYI4AEWfsQ47vdvF5frMQNMqfRCdw4XdYF5ZxpEeKGj1sS1Lg1Ng1obnCyxCSKRgjMnTzOB7d3YLW1lds6MrqDd2ZXMgMjSS5nNt4mGFmgHlmXNJWxsNMq8bek74P3A735AdUxMpebduvoKC+WB7DyCtHoEVJgUZN3vnwFapQRIyztAdWhY9CQ0Q6FtlbPWuF9dvVFPuGSs1Y3yZcX8VmrrQax4WVdFyxOUpnrUm/XF/hsdDDNclEIT4fc3Tg77goMyanEdfiVnLBP2e8xgnzp1DdJxEP5Kwap9lgCI59O8untjcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CFn280bniaDrhxuZuZW+EM127MI3QtruyqK4KC9A/I=;
 b=DzTkk3aJCYN8vUsFhzPbKX4S6663zimdCYPIKxKtYeBWJ3J7iWEMRgCkk27b1kyENEM8LoNat9oLesaM6yr1WPH4+cgNev1o56o+edw8+rIJ1PewfIswMiyOOniyf8jnu51JeFqVPgmGkgcSoCbk26pfk1RxYgK01qQsU16S2A906Xa7YSTyCt4ZgyIQDUVQFMEREIb3j5+QIO5/h3WGWcd26VYxvpHJ69x6l7W/N827iN0vOk27brit006VYIJejnSgjOKexvmqOagShP/jSS5eIe3YPJsqJmWA1P0wRyX1huOG+wAF15HR7ZgIJ3zJGeT4mNrLYBJ4xZ5JFLqGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CFn280bniaDrhxuZuZW+EM127MI3QtruyqK4KC9A/I=;
 b=S/UayndSyELB4ViuAUSrwvag+S6VS4hYNQNVk4sP3W4pXeYtf6zLJXEHTY3l/vc/9Y8wvMqGkV2iKsU6yV/y0/DHD1LvurewCOiugNoEBHxs4WAfzTiKRF+ouea6jmn5WzFEzbfa3uhvKWuk2tTbngSWWfzmhbX4uIFzD2MUTvYfiBPPxeh3n66f13tYO4Z9tSJGLk+C+ujRBnNY3NIK83sWU1Z34H8qCscWUCcusnlSG9V4/OW7McvJbLsqY2UTQTfhVtvBG9HR2Ye/YfAkLdieiwt+sAcWJ1mMGLxcd3xVPcZDl8BdOt7kLBNhrNkraCEhU0vviaS/NJ7PXlfBBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 02:23:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 02:23:19 +0000
Date:   Thu, 16 Feb 2023 22:23:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Message-ID: <Y+7lFpzbUMtWZffX@nvidia.com>
References: <20230201032115.631656-1-yanjun.zhu@intel.com>
 <Y+5FuSxVrtmCawC8@nvidia.com>
 <073e4d3b-f451-27f9-716a-2cd2e51d8535@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <073e4d3b-f451-27f9-716a-2cd2e51d8535@linux.dev>
X-ClientProxiedBy: BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bed8dd-3ad5-4665-2c3b-08db108def5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajYr3CFGrK7e4FbW4g9Ohq3f6FUvNP6LJMhD2v6ka3pAnWz6k9okPF9z8jsiL885Gfm5lOMaiLLwukDaX0MJm3wMJIrZsuOAfTF8DfUAn4B5NCAS/dnUMTflZTTK+0+78r7mUc6C4L1mK8p+Z5srwhUQQ+yfPqczt+7M36sImUQdeirzR74JI9a/jzdsW5OVjS3vf9jXCp1i7cEFrCTjcSieZoH1VQ5YAFE2T7Inpev6+1l56O4084j78PqxUYsJmY406jG9HBwLmShEyawcqqnvHc3YvMb4AcN6ia6xvwCzbOJkiHF5SsBZY0gSGt7QV9c8TZaTqoFK/Te0M1KNMy1eHYa1BX4DtrxOVygXPDMUhGiZnFc/qeycT9Fs7GJO/5Qe3rOAm74nTh9Tjl8WqnutMeMSAa4g2nOHk+WrsEgXcqRzD+M3zMPHUKvVR2Rt63GcSj3v/6SF4OBrI9uL7gmsaYg+yrW5n1nuio3Lud0xCG1M9y2OZVxEWNf3PBo79kCoxIHuQYQ/XXOBZNTioTPgMjxjzHrWBavBHGSOYu3dmhc3zRAhZTOzSMfrilvGviMb9Ipb4EK0bEKKMNjStHxp4eah7zxLyDpV5Bc/CCcahsiC9dwPDz+IDrI5zP0KqLbqHC/T1M1N1YoArgL9Mpco9JwnZsrxmHCBeZMt3chllk5XFhkjWcxCB1a0gVcDmpqLbA3URN4T4NEeYMOmkn9N60tpJEgqWcQJ+U0pqVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(66476007)(83380400001)(66556008)(8676002)(6916009)(4326008)(41300700001)(38100700002)(66946007)(8936002)(316002)(6486002)(5660300002)(2616005)(36756003)(2906002)(86362001)(6512007)(26005)(186003)(478600001)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZHbnIva3ZZM1N4RmszejVibFJmREk0YWJGNytidGZ2WmUzWFYwN21JaXZv?=
 =?utf-8?B?dnI2N3pQOU4xZXNwb0pTK0NaWTQwRnF0L2pUZ1dhQzAyLzF2UjdsalFoRTlU?=
 =?utf-8?B?U1lzKy8yRkhpS3pOWnZQbUtRamtidnBBMTJRWk1seE9pVlg5dmdIc2pVbExJ?=
 =?utf-8?B?aTloYjlXUk5ZRmNWa096WGRZWTVQR3djcVpIUUJYbWF4U0tjVldFRFIrK05G?=
 =?utf-8?B?ejFXejE5S1orMGFvcHU1ditSTU5tSlF4ODE1eXJtT2xIcGJLUDlRWVZRNEF0?=
 =?utf-8?B?SHhjUkpkVE1IUFhUdHFuL2tPSXVBNXRvSTVERGdrWDFxYVZBcm5UcEMrSFgr?=
 =?utf-8?B?OHdBTUk2K0Y2alFtRjJEcnNadXJqNWNpc2xkckk3amVVaklYZnFwQnVOVC9h?=
 =?utf-8?B?WGZ4Yys2Qk1NeXgxeWgraFRpUGFSWndWVlZiYTFhWkxUK0tHRjJxMURSNjdK?=
 =?utf-8?B?VUxDNDM3b1VtR2d5Rklwekp2ZTFRZDZacEJ1L2c3Zk81Yjh0YUZ2YXFsZW1K?=
 =?utf-8?B?NWFIMXYzVytqNUxTdzRaVnpMQTl6N1I3M1B1RjUvRURLZ0ltVmZwTXJPQW5q?=
 =?utf-8?B?ODl4U1Y3NU0xQzhkNmY1bTl2Z2VZNG5HSGNicEdja092U1oxZ2hqQVJmeGtY?=
 =?utf-8?B?Nmxyell5WTYwZ0NRRjNPVjc5bFFlRnhqNVhHQmFoNWtHTUhHRVd6anBrb2E2?=
 =?utf-8?B?cDlhN3k4Mk05cFRSbnlqTUVPSDVkMjgxcXYweHF3dC9ySEw2Vm5Lb3BickRD?=
 =?utf-8?B?L2hxTWVXVzNMaFJzQ3NoWDFrdUovV3A3SFdxamlnU21VSjVzZXRsNzk2dUpC?=
 =?utf-8?B?K2hXaVBwaVlORkw0NkNIeFlUNlBQeUZXN0haT3U5S3FaZ3JsbTREdnFhcllX?=
 =?utf-8?B?N0FLWC9paHQyc3FkcTVVWjNXVlNBOXRTU2JBbDNSVmdaOTRhYysydmliazV3?=
 =?utf-8?B?dlpCS3NQcm5jL3AxL05TUEpJbFhyVWpkeDROM0ZYQXVPZVE0RytJTzRqZkY0?=
 =?utf-8?B?aVZYUDFURE5vS3ZLOWFTS294L1RvT1dlTllaYk9QQXlGTWFROGwvbDdtU2NK?=
 =?utf-8?B?ckVVVDY5cGNQVC9rOHdmQWNJZVdSU2V5alAvQkd5TGJjalJGaEx6NkQ3eE9x?=
 =?utf-8?B?NlpUdDhEbFNrbjNkVTNFQmluTk5wMktNQ25nbXRiNzRZbnlpWlRNMkFqVmpO?=
 =?utf-8?B?Qm9nWVIyeXRSVmNHR1REeXF6cnBQNGxRLyt4dWVoSGdVR3RUZUcvT0dhYnBY?=
 =?utf-8?B?WlBWZTZ5dnVtTkgvcVI4RXNlZ21OYzZBVjlVbjNreE5XUVBMK3U3K0xpYlFr?=
 =?utf-8?B?LzBacFEzeEdSaVNIWnpnZTJRY1M4M3RraW45MDJKcHg1dm5YYnhWdDlrWWM4?=
 =?utf-8?B?T2Zzb3lHbWVaUW1MUkZoc05makhEVGJuNFR3SmJxMTFKbTdVRzExK0dGOUdR?=
 =?utf-8?B?ZUQ4WUdwRFlDYW50d244ZU51dUxyOWZ2NWlBcWQ2SXFVWTFXMXRINFpsaTFv?=
 =?utf-8?B?a2cwdW5VM0lqVzV0eFFqR1FpS3RVY2VLOE5PRUlsTllFTDB1R0c3cnkvRDBp?=
 =?utf-8?B?a3E0UHFMd2RWdUNGa3ZXbE5ZcnczdEIwcGRsQ3hzTjEzMEIwSEhnUzhLU1dE?=
 =?utf-8?B?L3JsM3Z4NlZrQ3hMSTFKQno2Zmd1VmJiT1RBUDczTzBDWERqSWd1K0ttakFL?=
 =?utf-8?B?U1BXbGpyaGtMQVNPYVAxeG11Tk1ORG03dnBYN1U5Vmx5TFNSL3ZhOGV4OFVs?=
 =?utf-8?B?VkZJT0NSNUZVaWU2WEdEVG9uczlQbEhyNWtPbTl4QTNEVXlSR1U1a1RhMGhO?=
 =?utf-8?B?eHhDazNZeGdYZFpUVFVKZFpmcVpRTTF6dmUxMC9xVklUeCsvWlIybDBadlV1?=
 =?utf-8?B?NEIrODBUTmZndzlCWVAwaW9Ic0RMMWNtak8xNGp2WEpBNE9JWW5FZHRCTDVW?=
 =?utf-8?B?WFE4Zk94VmNXTG1GeUJSQUhBNk9HY0sza1JJeDlvVWpyY1BENWE1cXlsKzNZ?=
 =?utf-8?B?bXI1cXpiVEp3TVNWOHZGK01Fbm9jdGZJb3QvWCtGRnhFNzJ3M3UrenVIcGVQ?=
 =?utf-8?B?MHZaQUdCM0hSR0xmMEl0c0RWZzgyWnpiZFEvbHpnZ2t1NzNWSXNsNU5ka3Rs?=
 =?utf-8?Q?1B418CeZqwu5qLshAwCOBegJ/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bed8dd-3ad5-4665-2c3b-08db108def5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 02:23:19.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxV3BzUSXtxL6bKlOKPxStN4s0G3bXeIZ/Myq46HnFB1F6tI4AkdvOOl+eFEQn97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 17, 2023 at 08:46:52AM +0800, Zhu Yanjun wrote:
> 
> 在 2023/2/16 23:03, Jason Gunthorpe 写道:
> > On Wed, Feb 01, 2023 at 11:21:15AM +0800, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > This is a followup to the EFA dmabuf[1]. Irdma driver currently does
> > > not support on-demand-paging(ODP). So it uses habanalabs as the
> > > dmabuf exporter, and irdma as the importer to allow for peer2peer
> > > access through libibverbs.
> > > 
> > > In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> > > This function is introduced in EFA dmabuf[1] which allows the driver
> > > to get a dmabuf umem which is pinned and does not require move_notify
> > > callback implementation. The returned umem is pinned and DMA mapped
> > > like standard cpu umems, and is released through ib_umem_release().
> > > 
> > > [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
> > > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > ---
> > > V2->V3: Remove unnecessary variable initialization;
> > >          Use error handler;
> > > V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
> > >          This commit is based on the shared functions from refactored
> > >          irdma_reg_user_mr.
> > > ---
> > >   drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++++
> > >   1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> > > index 6982f38596c8..7525f4cdf6fb 100644
> > > --- a/drivers/infiniband/hw/irdma/verbs.c
> > > +++ b/drivers/infiniband/hw/irdma/verbs.c
> > > @@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
> > >   	return ERR_PTR(err);
> > >   }
> > > +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> > > +					      u64 len, u64 virt,
> > > +					      int fd, int access,
> > > +					      struct ib_udata *udata)
> > > +{
> > > +	struct irdma_device *iwdev = to_iwdev(pd->device);
> > > +	struct ib_umem_dmabuf *umem_dmabuf;
> > > +	struct irdma_mr *iwmr;
> > > +	int err;
> > > +
> > > +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> > > +		return ERR_PTR(-EINVAL);
> > Shiraz is correct, I'm wondering how this even works. This is a new
> > style uAPI without UVERBS_ATTR_UHW so inlen should always be 0.
> 
> Got it. Thanks Shiraz and Jason.
> 
> I will remove the test of inlen in the latest commit.

Please answer how did you manage to test this?

Jason
