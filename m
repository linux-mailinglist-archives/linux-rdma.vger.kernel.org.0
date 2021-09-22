Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65147414C4A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhIVOpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 10:45:52 -0400
Received: from mail-bn1nam07on2065.outbound.protection.outlook.com ([40.107.212.65]:10818
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236164AbhIVOpt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 10:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Skv+N+ZPSKFaToBmW7Yd2bS1jQb6qr/G3XdIA3O7MKpIeC3qrBBmNQ0ZEElBgLiYOhRl/hqVCTNyrs/LEL1/f1XYO2h+WVJbHWlMvWc9tXcd/+YTrxK2r7mI9mtguKPHdkKxAOPARIH1Edv5aO+jXZocbvCdC6W7TTRh9WW5lBZ7xceEoqjNeflAokwdQPAYATU4Eh3ZUDB1tLGnZBboTvviDWs1bj+hvTDMedNVxgT5iroxDfTjSerbuZ28bwDKf2lZf6V9XZEOd98ycP9FGhK+iJ1tahi/VBbsciWIzpQahPJcroCfMNZaZ7oDj6KauzweU/zs3Jo86FRghl7xYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=D6baqDbmQtCJ7/KpMOSy/nDHD+n1rELJIih41rIBrao=;
 b=c3rgH6b7g2cM8R35dMEIJLEaLy/yRB4ZIt6KWixdFeS+J928Ka6cGeaNwzVKpgTUXiKb2sDwyONQPEsEiZp2SNxdKt+4yQnnJvuv53i0Mxvb+YHlppjIFSgkLhyps21x312EnSZkuIVsW4Kfj1v4Ld1kOsuocvCpmBghU456oe5zkkeAqmqcqIMFPcjOf1FJlRREXh1ofQqOYgfQ5lncYWy+1rAC9rkFYzrrWyT6YHcNAThgSRDSFxYYgaYyt8nqxUHDllZtt9g7kEHaEh/CwwAG3ydQ+uTo2gkZJ//bkSGJPu/NW2043k5glVYlZ4Z9lqBnVdPlDvJamCztEqPTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6baqDbmQtCJ7/KpMOSy/nDHD+n1rELJIih41rIBrao=;
 b=o/5xbhd3JFtpFrx1/c8tui2AdT5mM7yQSpqsdd0NdXMME0NyexUkvGJSinv2144xIQ9NlfnUpO7qacaDWlQw+wuTgL0hYD9CYFvZfWaE8D5lAOU7jHiRZBSDrRUwJQuO6/R60Zpgb+UxYaM0phTt+7Mt+qf6+CDBCi5supopg37+FddFC08MF8pAJhka4abFV4Ch+mXRoo38b+NtpRNyWHLP5dc2BxS52e0Zi/2rwHX0Kj5AI3rnBihLDIlPA/YNd0jLK9XZOGrTsbbR08jQRDGA21N28WtB1NnVxDRgtyvvp3OVN4UM82lGxNdG4iGiXkLI+Jck02SIZjflLd0xzg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 14:44:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 14:44:18 +0000
Date:   Wed, 22 Sep 2021 11:44:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com" 
        <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <20210922144417.GW327412@nvidia.com>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <27C1E678-2EC4-4916-9720-00C1B69EA5AA@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27C1E678-2EC4-4916-9720-00C1B69EA5AA@oracle.com>
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0064.namprd03.prod.outlook.com (2603:10b6:208:329::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Wed, 22 Sep 2021 14:44:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mT3Tt-003z1f-4R; Wed, 22 Sep 2021 11:44:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5d68ab-0e1c-4f5b-6ec8-08d97dd774cc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51599A8E2C363FE5A85DC39FC2A29@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGX06VOT+p7PL8HfASwFSqICU1t0FWt/bHHFrz8Q9q0H8611+glsjKIvuUGFXk5Sx9SrzDgLlPPxyJIQfVnDmAvtkFtRm7ILg0CkzbmySeNG2AZwH3W/v5Rh8IPlcAP6OubE/NWhLq9k5pOC9AlI4KSzu1aj+bfrH4++ONFu7+TTDVwybPKPlfPDEVXNXon7ahBQA+b5EJLFdcgp6ROjgOVjD16RkUMO+g0nNaLYYQgBwtayXh6xrup8lyAvfeCNolMlSjCahc+/lcY7DkPdCzPmLQPhaFe9nJMlTjs2sjubMy2LUJxnWaavciAwQtRvZ3Kb6Um/MK+e1dXEudXXHlSBnUU7NUIfwIxgQXL12pT7a5KQFERo80fdAFgVAVoZGgAN+ve0B3hU9uaUGc2T2zh0TvHDrMVDipA29JlEHoKSEi0417v8Av9lFjj1GBrOgDQrLwKeEMw5H9UNyUqSwzHD1Dw8crKvOM+SDkm6uST/bl/hbwavk7HscLbTAabEBlNZb5MyLK2GEvDabzg1OYulRjAvmBaYTYHCTgMlh2aica5fnMmDFvZhTBmhpUHHtbqW9k/VpVy1jb818Ht3YeyWPSxEQBq9X1VFFU7gfZTs6sOjcQD9l2Fvy92Dhe4bMO+fzvDauLMIpYzUIiC9Ui9BIDPAEsfTxDmkOIlTn5be+txfEhLzDuywBrgyOCym
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(38100700002)(8936002)(508600001)(33656002)(316002)(8676002)(1076003)(5660300002)(186003)(83380400001)(86362001)(9786002)(9746002)(66946007)(54906003)(66556008)(36756003)(426003)(26005)(4326008)(66476007)(6916009)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A5xidHEM4jdYpMjMXERrLRr5FYfn/4SSwFsIu0fWATS7JX7zU5d37cPj5rLk?=
 =?us-ascii?Q?ravaU/O1hbiuhare8Z+xCl3drNMYvP4R09iIA6mKsnXb0gvbCTw6qPGa90Du?=
 =?us-ascii?Q?cjew6I2YM4WZAb1yFrOjekn5SrJr2M23OyW0CvtAsnL47Q5rvhzhBgP6lLpD?=
 =?us-ascii?Q?Fwn6zppF9CRN0BTwOyHjhYMIRqJoZeY+HlqCxQ5fxUOpbb0EXofPV2RdEMBS?=
 =?us-ascii?Q?00vlfnwWu1eDubDQnAWV/9ASxXMFNVXhKwzczAun2dXDf4nMca0MLkHDImNA?=
 =?us-ascii?Q?6jI9pmc93Xgm8KNjkkgBlHlZioDe2QY7zO0ZN8jOH9+Kh4q0ku9tL3GWL4eY?=
 =?us-ascii?Q?DqNh9b/COCtiBBzGKzNY0xK8WXzBMVREoVOTTO5dGTXUObhusl2sGOE+4yke?=
 =?us-ascii?Q?j/HO4rlzEvaHFU2pjgfD/v42As0KkdM+cOd7OOQKuZVq74BmG+ntxzQD/wLk?=
 =?us-ascii?Q?EEEIUkjt2TwpryKeBR3iednZXZ1KWzu6pjuU/2zbxLXc3+fg9XI4DWkTZI9q?=
 =?us-ascii?Q?eotn+spLWUpBiNLIRF8NG4P011r40e4ykTiFWx97LHK8qlgGHKR7+cAxyGn1?=
 =?us-ascii?Q?838yyHuC51u7Bn4hweEg6W+D+tjIntenmpMlXRNoIWdblGSsMQETztTWKNmC?=
 =?us-ascii?Q?iEABFbMJzNpvBefrUynpWX91S/2nXAHN/iH8MKJzoGG+oHplbXQ46mQwI/p5?=
 =?us-ascii?Q?ypnnoz4V1l/WPFKgtMDd+q2GoES516R43bfrJ7RdiWXrbxu2OfYNEUUEM3mn?=
 =?us-ascii?Q?vkwsFKObcuUjbq1XxrE8utum1V6bKvlvp2VXHwLkagqE1JIDOgHRj2oLVkq7?=
 =?us-ascii?Q?yQm4pBj9OiQ5u7cHb0jNVETkjI3jOXE6pkn2LStsRDfyz3u0vJLY4pLthGCe?=
 =?us-ascii?Q?rSeiqwt/hYKE+ZwUCrqfXNrAKH+7rdRuzW4R71oJyylqpz5b+9d8xfW16yg9?=
 =?us-ascii?Q?B4WkCPxM3AfNGru5mtIEKZIPP08KYTrY/ETXa0kRqmcsYcZu8DrppF55lIX/?=
 =?us-ascii?Q?MUP42XRQSjf6sE7E8hR/3V8USJYUMHrWyxDNejGrPLnqGkzvlvCQPHAVtr2/?=
 =?us-ascii?Q?9vm9o2gFuwHoG9W5BKCEqL10JQG0tKVxNd2+3PSI2Kwx3peSlsa96cm+JOn3?=
 =?us-ascii?Q?U0oY43NDQolV1tXDhm3i0FLBtVosiCCy17zDxAZ12HACdMq/SmG1z9AXkM/G?=
 =?us-ascii?Q?gbNLOiAuB5ubC/RriiNul/EpHTe1wVMUg12wFFK1iklP603KtVoKraEIIo0A?=
 =?us-ascii?Q?4Ump4n1D7bzEUKfkGikhTglplVZrMKSDCatoiJP5dlOiAgRT1KFa1XXhhrxS?=
 =?us-ascii?Q?SV/bLhO03YhNOLsVwq/0nNG3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d68ab-0e1c-4f5b-6ec8-08d97dd774cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 14:44:18.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MP1WX2qYc76NyGtwMotxLaYvsE4tOIWmgZbIzY0BhCtybEkRYPgjnLOnWFrsGKo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 09:38:40AM +0000, Haakon Bugge wrote:
> >> @@ -3413,6 +3421,15 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
> >> 		if (dst_addr->sa_family == AF_IB) {
> >> 			ret = cma_resolve_ib_addr(id_priv);
> >> 		} else {
> >> +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> >> +			 * rdma_resolve_ip() is called, eg through the error
> >> +			 * path in addr_handler. If this happens the existing
> >> +			 * request must be canceled before issuing a new one.
> >> +			 */
> >> +			if (id_priv->used_resolve_ip)
> >> +				rdma_addr_cancel(&id->route.addr.dev_addr);
> >> +			else
> >> +				id_priv->used_resolve_ip = 1;
> > 
> > Why don't you never clear this field? If you assume that this is one lifetime
> > event, can you please add a comment with an explanation "why"?
> 
> Adding to that, don't you need {READ,WRITE}_ONCE when accessing
> used_resolve_ip? 

The FSM logic guarentees there is no concurrent access here, this is
the only thread that can be in this state at this point.

> Or will the write to it obtain global visibility because
> mutex_unlock(&ctx->mutex) is executed before any other context can
> read it?

Global visibility flows indirectly through the rdma_resolve_ip() to
the work. Basically when the rdma_resolve_ip schedules the work it
does a full release, then the work does a spinlock/unlock which is
another full release, finally the next time we go through this
function it does another spinlock/unlock which will act as ancquire
for this store.

Jason
