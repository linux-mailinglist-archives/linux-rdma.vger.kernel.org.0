Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE0690EA4
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Feb 2023 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBIQvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjBIQvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 11:51:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C55B75F
        for <linux-rdma@vger.kernel.org>; Thu,  9 Feb 2023 08:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q59YFanWF6au04HT5Htw/lRysLXmZXqz2+JSluvkrDmaPC+3YIkNQ3ArkdhAm+e7tJIDvVgPHCTC6NpnOYt0m0oo1HnypncJ6eLH+EiY4eufJSfbngmtZtPchLbGdRwfy5zNGzjJkeGNjr9dBI/E/E3WIuuMiWzkkjuzRpd0NDkToWK2bNrYpZjFx8RqTdsXEMi/+N7Ovdb3iWjFodrZmcZSKREIxLDoVjKa046rdWzYRjyIsA5NRK7YVc6Dkjzibo585PdFlMe6MSbI1KP/srMNhIHIvNKRZupzzvIOlIuVRgtke5x/l0JB/lZ1VLZJ9RQINRE7TikiUNeT40Aoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am2q2oa0O9dMI8eFYGvvFPq/LZ8aZm/TqOyxgEgfNz8=;
 b=ZT9mkNFC6+gDbN8zS1rB3Hn1V/PcQAseqmvANzCYwddH6BF+vY9fEyrc6xMnC2FPWPS5ICZ7F1/Pa884ZA5jHIZglpm4eRkTEuLib9vnT9NC/AiUor+RJ+b9G6VHBp/5JqASHFU11TC2P3ClYPQV1VXOaiCsZEzXt0DYAvg3XHU388lhNqvrQvEZQGN+D4m6ImuIBXxTotEuAWYy/aXZyx6R/aZF/qJ/OwXzazU9dHWaxFwDT+0jleE5QyC4TsMBEMuzaZ6QEosg/kZPbwu6y3CRE0lhxOe8l5wONlBrCU4c6ClG0aCLRS85vgZvLoi57BG+6NHtqIG3PZN3PT3Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am2q2oa0O9dMI8eFYGvvFPq/LZ8aZm/TqOyxgEgfNz8=;
 b=YWgf11Qn5RNUQj5v3BeZjbzzYBI8e/e8tzFFufOUfLW17+IkTj1/K8k3rkmcg77LuaeB18nNoqwrzJFsL451biuLmqMiypr6Qci3/E3AWmjDoFRbA/Lt97thrx3XLpSnx8OKgRxDMKwH2xTVPd3gSUaaj7f6YLozvZm/jJBjhaI8P0tvWA0UbN6kG+czZ6TRF4Ez0ESLFi59ykma7rSf1A3/k6HEhDEUhFYRGqLxf90Vz0W7auV/12+JvCaRa7Eod7YmqL7sXRwf0mBv9qD0m8nwcGNJT/z2MUobfqK38QDalBb223l3XJ4Kl5eDiAqnqL38o/5p7hI8kLK8oclgLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 16:51:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 16:51:38 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Davidlohr Bueso <dbueso@suse.de>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] RDMA/umem: Remove unused 'work' member from struct ib_umem
Date:   Thu,  9 Feb 2023 12:51:36 -0400
Message-Id: <0-v1-22a2667fa089+a3-umem_work_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:c0::45) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bac295-c9a8-4fee-67b1-08db0abde958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adQnKk+xbKyrod4idw6p13/ZcT42peXUD3wFpBy9hVdGrCu9xl4+H+zhqX1TxlkEgcGi0C4An+caVq84CabTHr18Z985sdWOBeH6tFWNLesIyLdeBwz/3ZBYn2C1GJ3tjUgvkD3YpuB3eaDmx25EyAtBTjtlPU0Fs+PTyljPI+CqnivX70H9sbX8nZ9IKx2WQL1hOQ1Htb/i6ucUwWEOR3oGmaSx9gS1pZxBJV+yyFBYlvKfFM3WR0S4wFDn3hS4EGs04Bx/5z+LBJY8qzaIoZUTs/9LX5gRDNW53xkNq9hg6uZxdfwbb9gmOvpqA0LwuXd/VH/De4YQXvAzEMjW/1nAq2I5rlBZ4lphFMVuUcSPouwJyFe1MhVhv4HJTaFwOarCZIY7mdXZsoivJCzTJYF2JozkKU8rnFXOW/vAicrMufcbGYG1ULfcWypz6+VKxlNlgqQ4FlFM6gnkpW6UwKkuiZ3QrtQELEnSP5YXRnz1tHCDuiLXUIZwlTwCEc07AFIazKrVdoOD4PaKq+GUdsX2Z8Ebdg/1NG2C5U3zIejumuaj2pemtsVNuE38lYRmu2u5whCGQhyY6KJlXW8qHIWllEvlNyKzqz+pz7Spd5Dt21WBrI4SPnxUGhFFKuPQ+fNFG/SLm91OX8Ug9xNg0qfopOO1tzo7OJihHj8NSdXZ0Ca2DFm3MdWPgvenvypf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199018)(66556008)(38100700002)(316002)(8676002)(8936002)(66946007)(41300700001)(66476007)(2906002)(5660300002)(4326008)(2616005)(6506007)(4744005)(6486002)(478600001)(6512007)(26005)(186003)(54906003)(86362001)(36756003)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vejtpowg1zRrO31KCls9K17Bq+PezyazvhL3+I7fw9UxHIc8ZlObebf667y8?=
 =?us-ascii?Q?KYeBcJ9a+DO6D/dPuxgpS/iqU+5UjtoeMQ+tR+Ex4uqa5eyhevOhutpEsrBT?=
 =?us-ascii?Q?ePgZjNwo92w1+y2d2fUvkzZi0XZmZs0fYRkGOcvAnqXdvfR5afTuJUUO3BBB?=
 =?us-ascii?Q?WQ5dz1XzTHS3QcVu38oLeYbkWeLZy4R3lxNf/LtdDLkCOOck5+2OS2KMieyS?=
 =?us-ascii?Q?v2gswgkboGVKP4+4J4SmSjcgEc9rG1HWYIiKOg/ExR8xHOMY/3PrYJwqGIyN?=
 =?us-ascii?Q?XlvNPOITL5EEL89Yk5Q2GzPyuaFHXP5NDLWrkXTfSwEdOdV9AZIJyx+/Yigk?=
 =?us-ascii?Q?vo1f2WQ9acdjpSwbWI3soiMtPM1eKHUJB6VoZYliBJIdT+6AT6Nj1iD7XQik?=
 =?us-ascii?Q?dBj0MnbkupmfqPEh7QnDAhkmu2mNg+LexsTsIYV3vYZfVxbbarPRy+L2QfCt?=
 =?us-ascii?Q?eP0bt8yOy35RmYeUs1CjiwS7YbGzjspho1a+/G9OtM9SlLXVx+L1Dyncb30k?=
 =?us-ascii?Q?Ygu52YxPfqZxUprKbapmFieCcUJIo1HrinUo4kI/V9dVgCc0nGRS4FKwGqtL?=
 =?us-ascii?Q?oUVRigChVGiWb2qkEQ9kneJHumcebDkBAUhkZ23lFRZpr9zOdAwbnUiY8j85?=
 =?us-ascii?Q?Is1tEjtt4DSuFiNYg2MBPozJN6cKP9ykRV3Bi/h8yc40JaJssFSCyRRetIDH?=
 =?us-ascii?Q?m3B9MkbBabpUVW7qq8axk00ge6pIOMrRfe88spUWYLclLa16UcEyu9FlcS8a?=
 =?us-ascii?Q?Rk9aT8UiZL9s3JIaBgBfxskosKdtuJRegzVM/1AtAM2uI+T+cHrGIKTSeE7e?=
 =?us-ascii?Q?guSPYcl1iRVX6CkULcCkp6KQvZvm7ylGAQNnBMZqq8ZnbRpiKjED8rZhDelE?=
 =?us-ascii?Q?60hanAy9jEp+siQ5NrOPrETJQCzo9fg6xiJCaySxUOVY2OHI3k61jPuajklY?=
 =?us-ascii?Q?AgmFg0TQKarmQIRycGicYHjcBZCKvZPfC9pkvtfrOjbQ6cJHrIGQxOuUMTpK?=
 =?us-ascii?Q?U4g1oJp2oycUSvCRdr00at1G8a9DJ97VSzEy0mpWPEpk3M1G0dReeVjrB0h3?=
 =?us-ascii?Q?Y6D/wSuoOYWoQBNxmv+NZc57sksuZXNCLFmbODP8nX2e+Lug1hcs0H5pEDKc?=
 =?us-ascii?Q?bNp5KZobeZhdumYXZAKxhVLcomVB0ojrwa1w2Yggo+gG7vv0++D+DphLM1Lo?=
 =?us-ascii?Q?jbbOIoHNOPOm2V3t4tKaZ7GuwE/szG1POQz39HeVXmjfmsg1w8u6/P4AHboW?=
 =?us-ascii?Q?9eTf82+szy4sJ8r9U6lM5GbQctYXB/KRTvTT/NGrEoKeV5ikbBbPr00UuLmn?=
 =?us-ascii?Q?n1RIy3FioNJXufAasVJGRfq7t+6QIRN75VbC6MfBgf86K2z4OfQ1SEo1nK69?=
 =?us-ascii?Q?tgfka4gv86eUt9j9asjYLSDyz+lvfPO3CcK2WLGanxpnPPmO/qJdOjaiG8t6?=
 =?us-ascii?Q?dh+bMd7pNGY6HVFnStGYCNraR7kjikx1eu3iW50EDUUaB5jzHPMKgtOc2CQ2?=
 =?us-ascii?Q?xcQPppUSTLDMpr2Ymy7i+ppp7w+fTFpvgQWcMKSzjIBAbnifKGiS77dJzjl1?=
 =?us-ascii?Q?n5GLUeb7SIYeKI52qeEYZVAuKoB5UE39VmDaJsZM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bac295-c9a8-4fee-67b1-08db0abde958
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:51:38.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irrskJuBKYa/zQ7HOB/VT/xjvK0eey9xCFa5fKP6BfqRTje33V7eBdG213LEc8zY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is not used now.

Fixes: b95df5e3e459 ("drivers/IB,core: reduce scope of mmap_sem")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_umem.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 92a673cd9b4fd7..95896472a82bfb 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -25,7 +25,6 @@ struct ib_umem {
 	u32 writable : 1;
 	u32 is_odp : 1;
 	u32 is_dmabuf : 1;
-	struct work_struct	work;
 	struct sg_append_table sgt_append;
 };
 

base-commit: 627122280c878cf5d3cda2d2c5a0a8f6a7e35cb7
-- 
2.39.1

