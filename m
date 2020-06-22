Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF320374C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgFVMxJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 08:53:09 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:59459
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728024AbgFVMxE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 08:53:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOmyeltA9uN360HhnPdHaZM4VVXbtg0fBghUFxgBeb3KLgfjiijH23m1izprRoji+eJPElltdwcjnL4kyAEorSt0ieHCK2/Dq9SYE9txJ7RS7e/WFGJWjlyMnJ8BPt+kaPKj05qivSfDziL3zBtjapz49x2psOf8VsuKdqI+1poFOgRppnmrQYacu1Z3eV8KMuIGe9A824sVURd8aww1ttfUVY78ew2YXGnBhCOd9tQGnYzZ5CK2BUBDMsW2U7XOzluIPI9ilQUbWMobhVbY9ZOUV5lFG/P1ujxyNiEmgUqyfGkjn507v1Er0UGSSVGVqmOFUHX3E7Mxi5OF96cPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3ITcCS4gQrUi/ngF96iXmAywIfh7dBfziml0Qe7SFs=;
 b=PsDHhIsAYE8cpfVk1m1kCg2FMRrJI15fDEyYKkYxdM68pmRUY+dsKaUdQqIVphdiLJ1W/l39iqiStH41VT9XFpkI1fPvDat8pZpEL3CkYbMDuAl5+JNK/Rsbs4ku0MhoExP97Z07ff5HFiOhycW6d9tNXvUkF0DZmDlCySCY6m93/hBolNFuiULcAFKTXQSUyTQJ+XWI+nTMtRi14PFN5CRq1L30/gxY9opTr5ynABxdGgM61Fa+TWpSYbGx9uxCpmE7JiYpDJ3rJZDKN0UbrJiloMTHop4bxT1Qh9iVShAVZgGLCJR05M8ewfpRcDan62EJ3VtthBM9swWCYu+yrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3ITcCS4gQrUi/ngF96iXmAywIfh7dBfziml0Qe7SFs=;
 b=k+ZlnCjDJRjmWBwcH/7gBPgLM66RGeWGVDgJEaqlouBQsEbj+y3FyhTTZRMT6DcAFkU6NsgZ/AMlfA85sA7ydb2fRbtlpd/JUUCIAe8WxoroShboPrnwE1CornnSmRZpYB693XKtc7M1b1wvUcda7uzXtME+RlYmZxGFJPKsWWw=
Authentication-Results: dev.mellanox.co.il; dkim=none (message not signed)
 header.d=none;dev.mellanox.co.il; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6976.eurprd05.prod.outlook.com (2603:10a6:800:18c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 12:53:00 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 12:53:00 +0000
Date:   Mon, 22 Jun 2020 09:52:56 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
Subject: Re: [PATCH rdma-core 03/13] verbs: Introduce ibv_import_device() verb
Message-ID: <20200622125256.GD2590509@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-4-git-send-email-yishaih@mellanox.com>
 <20200619122928.GT65026@mellanox.com>
 <5a71a881-6232-e7fb-6f20-10fc973778b2@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a71a881-6232-e7fb-6f20-10fc973778b2@dev.mellanox.co.il>
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:53:00 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnLwW-00BtMw-K9; Mon, 22 Jun 2020 09:52:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4038a1e8-ef46-41b8-cb06-08d816ab31b2
X-MS-TrafficTypeDiagnostic: VI1PR05MB6976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB697650B2EC4016C85416E64ACF970@VI1PR05MB6976.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/Bl3b5ofAFplSeY5OP98GpB4rfQBj0ubfeQJKPYxtQl7jIln77OahzykEMsd4oqPWVXfua9fSmEaC/6srp2NwNOKX2lCgjzgSSmQLARJ3CE5HjvsTKVy0hdtXODJrOMveqk3bY+k6jg7auwlbXp0VPYR54NHFGHLncvvNuZZ0bSK0xj/H6fugr3t5L878FBui94KlcmfOHRxqGodRKQh14gYm1ORvJCSjSuFdtv077hvQ2qv49Ll3dCn/Yn0xij1kDhvslcUObYEyVoORgmLrTecbeeb+GMiTE7JAwqI3Sd1Vif1Xp9IoovcmLv30HOJ4hkP4MiqcydMrRKmbb7Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(33656002)(26005)(53546011)(8676002)(6862004)(1076003)(66946007)(5660300002)(66476007)(4326008)(478600001)(86362001)(426003)(66556008)(316002)(36756003)(186003)(8936002)(2616005)(2906002)(9746002)(107886003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OMwO2nLO3GSsJO/28kE2jYw8sg2ii+6b5cgjApR9qSZmvlMxi5yMZ9/ORoFa3YZ45haTpfqFbKcI4ZS+UwYvt259yQAMAEGtcV9D3Kne06SL7nzjJA8sC+lzckIdiznuNTaxTgcGaTaXyvrkKInOuf6U5fnLPTzfmtHlpTFz4Q+XdV1L6PhGRD0godvgY6jgEJ7SW6UH3GO14CCYo+UBS9Uujw8GXJJN8LqXeMhAaLs5oGYu3ClWW2Qb8lVoKrxwxwhf9TyK+i/ASrXGqBEVXbuWcGaJGvehJLXea9MsbH1fQwRVwu1yF6iRqmaBO3L7gzlt7N4cUQ13Mh4MXChTzUFx3u84oQthFvs3Rg1gKdWUOrK/WtgzqBkSHErwUrZTjP+akLROslNw08uiNn33vcWVaWXN1cN8UPTt1HB1fgL/HuVyO5IkTFB6SRdRa41q8+ZctRugiePWbmAf1q6nFrojBMP6g5k44XRtTmUd5J8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4038a1e8-ef46-41b8-cb06-08d816ab31b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:53:00.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eafgObXIt/ZleKLiLyngPY0hQWOu4y7okGgpp1RUNHWfzm5m0aMWfndWk/RQR9zS8sel8nyryn/HjZLf/w/ppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6976
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 10:01:24AM +0300, Yishai Hadas wrote:
> On 6/19/2020 3:29 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2020 at 10:45:46AM +0300, Yishai Hadas wrote:
> > > +static struct ibv_context *verbs_import_device(int cmd_fd)
> > > +{
> > > +	struct verbs_device *verbs_device = NULL;
> > > +	struct verbs_context *context_ex;
> > > +	struct ibv_device **dev_list;
> > > +	struct ibv_context *ctx = NULL;
> > > +	struct stat st;
> > > +	int i;
> > > +
> > > +	if (fstat(cmd_fd, &st) || !S_ISCHR(st.st_mode)) {
> > > +		errno = EINVAL;
> > > +		return NULL;
> > > +	}
> > > +
> > > +	dev_list = ibv_get_device_list(NULL);
> > > +	if (!dev_list) {
> > > +		errno = ENODEV;
> > > +		return NULL;
> > > +	}
> > > +
> > > +	for (i = 0; dev_list[i]; ++i) {
> > > +		if (verbs_get_device(dev_list[i])->sysfs->sysfs_cdev ==
> > > +					st.st_rdev) {
> > > +			verbs_device = verbs_get_device(dev_list[i]);
> > > +			break;
> > > +		}
> > > +	}
> > 
> > Unfortunately it looks like there is a small race here, the struct
> > ib_uverbs_file can exist beyond the lifetime of the cdev number - the
> > uverbs_ida is freed in ib_uverbs_remove_one() and files can still be
> > open past that point.
> > 
> 
> Are you referring to the option that we might end up with importing a device
> that was already dissociated ?  the below call to ops->import_context() will
> just fail with -EIO upon calling on this FD to the query_context method, so
> I believe that we should be fine here.

Okay, lets have a comment then, it is tricky

Jason
