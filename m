Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E00416654
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbhIWUFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 16:05:34 -0400
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:27648
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243063AbhIWUFd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 16:05:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxk9IKCnWaiq0LMtyNGsBRM6rNNDoM+E4HNpVa3ztJ7Bnq/wQZeJAIoMynU9vIGMm+y8h1hCp4jfSpzbUrnED3Az/CyrTsYjcGluVXb2QrnuckHoaJTaQYVFTSaBdkvmq99zyMOzvthfFWh5RJcmgdxEm/WJzTNKVKGcBNI/YPYnzqSIrMJNnw952yZYg2qsAfBLW+yKOYv9ldFdd0pMXTdJ8+8VT62ezyGiVRQhIYWieCM+Irh+UA9iToJ61NU9gUWKZSbte4vPVqbU0wwIBBgsc1hr4uOgL9+FX6zJCsUWYQNQnqXRpyrkyCT5DqLK8aJwsmkCgjWSHN7TlpFU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AUizWe0TAc70erRJxqmgeRVhT//fS272qQcNo49S2tU=;
 b=kqWtqFghH/zeue6CWFFuhn+14i3rCrkHDMWyCbs9pppUHkd4L+ZoNcbveHuwpLCCwNTjtOU2/SNFe4qGTjFyBdV4ATi+gXLIBOPIDzX/mAO4J/xzmCuyr4K+VXh/gq3RMnHP9nTuqNJNK7KOlI+K2flsLm0yv+cxDtkfiNG7nD8pvwxZvk1z896FPK8oteb8f8h7SNR2YrICVUU9O6Xw3ly8V+dmRrwo+s8YROybYsbWAn3gz8cf7ttolWCiE7gNQ+2rDl+JZjlgE5biFmeTJsJAZezZIfRxYJ3C2GL2FXkV0rsd3FGsfRQRaCrffByz3F96vEhN0m0vttMsFjPOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUizWe0TAc70erRJxqmgeRVhT//fS272qQcNo49S2tU=;
 b=f2pCc5Hn06IV8MBIIoih+p2pM9JFKaAooEH3kgiRXLLI/CZYt1GnfwJM1KGCdhl2BMXtcnlO1taica78r32TWcceryAgEMguiPTLqNsk/ULuqy6kuAgmoinjLicpFhAydRvSR4WpvmYOilMsd0Lltn3iohhk5gSPM1RQ4/2v/6T7Q0/eGkNFr5lCOZXvVjQvjihBOA+HSBbymYTVUS0J8eaxV2/KcEkqgO16tILQ8ltgjmd8FvrdJjqaN6DUlp6zOeC8X6pMJnv0O0saZkb3vW/TT/EnK3kg7ZcJ1bhDCIn5qqckjqJsXhD1JxGXUKez2gm0Zt0adsA2Y4Hu7famkQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 20:04:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 20:04:00 +0000
Date:   Thu, 23 Sep 2021 17:03:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <20210923200358.GR964074@nvidia.com>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <20210922144119.GV327412@nvidia.com>
 <YUwVUjrqT2PyVEO7@unreal>
 <20210923114557.GI964074@nvidia.com>
 <YUzEUM8RPlFZSbJx@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzEUM8RPlFZSbJx@unreal>
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Thu, 23 Sep 2021 20:04:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTUwo-004WtN-Tu; Thu, 23 Sep 2021 17:03:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c9ed007-0d76-43fe-b527-08d97ecd48d4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5507448FA7A95A9C24F2D284C2A39@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RN8TsB8SG3O/0Z9fcNkdgFyaQaeeff+6Se3+ORleadGKucGQrg4mpWM4D3ALpFCSyksbYingercskkyzLb6tlYiMLOISM22RydAUrzxEkB6ZlbkeMWsYTGumDtu7rAr+n7RLPA86H+w80GNL5Mt7z/MR6ND2sBnwHxF/YPdJkXmjYKpm4VEClWthTn/XoDyYt2yoJNywjT8HsjyysuP/+8nOGj0BmU9vYte0vebM0vl4qS0/BtFCIYszk7T+pTg7RDsX7M3HZdCuTGiYLgTGshDgnPVVT3kax6nF+/izJ4eGIjBm/XUCRcMli5xkTNAn/gpIiwBqmWc5jPVgn7JLEIzKxxaqz34ll41D+XKjlLOHT+4CxH7Q7p9PiR9n/24gEKr8hu41drRTTVLTsKdPhfFJlcGTMuLA6MeT8FzQHq8xJaWS9phAJPb5qPpHDoNruSjOcl7jE618BojBBE7rwsHt7ilaoKakZ9w3xT5ftRM0RGQpjM/2Sdu95d6mfEwRuUEBK21MeU7x+qD0N/N3UvSibXToRM8ATkY2+wX7uyrA1U70fkHF4lL0RwirkGB4du9Nwzpj1MuVf9Kv0ECFcHT7y+XNtz2xoG8XzgrlYKYwJXqRJGxpUE5QfmFLBvh3aHyasHNIlerCXTDhJ+/QG6776V+4qunbcIi55xK7eIAwouaRNfI2cMG3X5pTFDe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66556008)(186003)(2906002)(9746002)(2616005)(66476007)(316002)(508600001)(83380400001)(8676002)(36756003)(4326008)(26005)(9786002)(426003)(38100700002)(1076003)(5660300002)(86362001)(6916009)(66946007)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VK/QOIqSU9JxSr52jq2RftIvue450s44hK4yaaBPs9jqoBIwEbpwzb8BUkSJ?=
 =?us-ascii?Q?as9UxYtDXRZCTa3z/hwdPj4LU26bGIiJ5fdrYtROB5EG6KAHqwN4X8Cy3Jy1?=
 =?us-ascii?Q?Ml2pnkEm2j28wPBXmiLKkJ0amfkQ06JDD4qk5OIPWbHWggBG783bGPoaTc10?=
 =?us-ascii?Q?wSo0D6CsMW94quiLiMelnHYbSqGOf7Cp5fevHzySHHSB8nETobOJFIPumjX7?=
 =?us-ascii?Q?2ATh5gcQWesTF4f0JKiMq/mzonCU8HJuTcW5a+woIbkRD3RCeXQbBejUDyzG?=
 =?us-ascii?Q?5+u4MmM4YskXnkfgqZOm6V3tztPWk9IBKixKHMKURoad2ODnbIV/hYp6eY2a?=
 =?us-ascii?Q?of9JmN0MPVi/bdYMixeEANxUhfqpc2XIm/5DjfegCa+o8AV3y0Uptm1n1Sc9?=
 =?us-ascii?Q?1LvTAlOCa4y8JKhxk1Nx3HidKprIuroNE5lWdj4VD+LPRYI95I4F1eX6/WK8?=
 =?us-ascii?Q?XFCj/L1819PJYdZPxxF5BNL43vZrqQ4aP8JftrBImNobiyjt1n+IhCxxo1J3?=
 =?us-ascii?Q?CftKOyS1jqbiJSv0Whh8BRYv5LPEJx/4BOdosQMS23YRlXLHGdOUdJa7NFm/?=
 =?us-ascii?Q?35MMK3S5OTN+PU1dPyuBuDEf4xUvqc8/DU9yHwRuLJUxZTU6vqcJoo0SloNA?=
 =?us-ascii?Q?NUh50HurJAr+gMwahyQk3SOcfCtKyTp5MaPzNCZOPdX946MMRg/kDz253xJt?=
 =?us-ascii?Q?d0hOKF6k124hfX1BTKOAvcWFcUc2nx2uBvpIKcPEf+OtdtSpsbNFb3wJzOM4?=
 =?us-ascii?Q?b6oGWnf6J2u4J/eKnbkNnjNjvUfUfN2DSeBQzFeGcP7sJ9HAgvww6Y+krpWn?=
 =?us-ascii?Q?9hWf9qzzSA5Ptc4MkPeXPPfwo6O0UAGDny8OW2t6qGis1OpJZsbG7VEdwX/c?=
 =?us-ascii?Q?me/oEzhySWhgIjI02q7TWFmIdBZfhVn39M4el5VvLkAng+nkwIfZGj8db8A9?=
 =?us-ascii?Q?PbZRVbHUX4lMQrM4GI5+vo4Ypwa5YkJrJSUnWK6bw2w+RwwLqnnp+pCb9XVr?=
 =?us-ascii?Q?YJ+I/259X2JzbKPBNVvF6imz94UeU6MdtpBGIE8fyWDYWOd2k7VmXupuWS/B?=
 =?us-ascii?Q?JmiVdXcL06tEJjjT9QCkv5hX62N+aBDVfB8xF85KF5ZUs5BTxcvo8qnqQiI+?=
 =?us-ascii?Q?VZ9x75SQ8nQFArNnBjnpFjHq7umM0lKNXeyT763A4QDJY45Seen8MTg2t26X?=
 =?us-ascii?Q?bu5qSFcuqq6o+GVoh//CwiWcF5KQyKSdiKhkB9QdFWneITeBtY49Cwm6mCis?=
 =?us-ascii?Q?KmC8eHnrRzJGYWfK9uCW/zgIUPoqfVnHqXtjf9zBWYTFBXQtneEqdP95pg2u?=
 =?us-ascii?Q?lZLeEgWBMTm1l1L1CC1X7b0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9ed007-0d76-43fe-b527-08d97ecd48d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 20:04:00.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bw1cFrbDRHaK1dmNDXfiLtBv4GWqKLwO311gngYqzfgZjfXe2LSS0IGJDCCgC3hG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 09:15:44PM +0300, Leon Romanovsky wrote:
> On Thu, Sep 23, 2021 at 08:45:57AM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 23, 2021 at 08:49:06AM +0300, Leon Romanovsky wrote:
> > > On Wed, Sep 22, 2021 at 11:41:19AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:
> > > > 
> > > > > > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > > > > > +			 * rdma_resolve_ip() is called, eg through the error
> > > > > > +			 * path in addr_handler. If this happens the existing
> > > > > > +			 * request must be canceled before issuing a new one.
> > > > > > +			 */
> > > > > > +			if (id_priv->used_resolve_ip)
> > > > > > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > > > > > +			else
> > > > > > +				id_priv->used_resolve_ip = 1;
> > > > > 
> > > > > Why don't you never clear this field?
> > > > 
> > > > The only case where it can be cleared is if we have called
> > > > rdma_addr_cancel(), and since this is the only place that does it and
> > > > immediately calls rdma_resolve_ip() again, there is no reason to ever
> > > > clear it.
> > > 
> > > IMHO, it is better to clear instead to rely on "the only place" semantic.
> > 
> > Then the code looks really silly:
> > 
> > 	if (id_priv->used_resolve_ip) {
> > 		rdma_addr_cancel(&id->route.addr.dev_addr);
> >                 id_priv->used_resolve_ip = 0;
> >         }
> >         id_priv->used_resolve_ip = 1;
> 
> So write comment why you don't need to clear used_resolve_ip, but don't
> leave it as it is now, where readers need to guess.
>

I think it is a bit wordy, but I put this:

			/*
			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
			 * rdma_resolve_ip() is called, eg through the error
			 * path in addr_handler(). If this happens the existing
			 * request must be canceled before issuing a new one.
			 * Since canceling a request is a bit slow and this
			 * oddball path is rare, keep track once a request has
			 * been issued. The track turns out to be a permanent
			 * state since this is the only cancel as it is
			 * immediately before rdma_resolve_ip().
			 */

And into for-rc

Jason
