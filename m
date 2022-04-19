Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA235072BC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Apr 2022 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354468AbiDSQQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiDSQQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 12:16:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9C344F3;
        Tue, 19 Apr 2022 09:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNnP0/dXnR2lhefABXWTzEEmA16OQNflKY0Ua8XsVveboinq8qiky4FDbB75HFGLfgZkJkCO8YwUtW48uoews6ayqMylOd06jluQ3d8I+/L4t/5eNPsksIwDF79FNA8BclEQya1MNN9Xm8RMcrbRJxTA7IrHnZfEow1WcbatiX5hCjcNyjM7U1VVAmAtzjKlo2AZ0UhFqJXO23xxm7ANfe5EVq+adfZzWFuatWhf/GeAyD1idbLTNkzUJjhabbaZ/gH/XMsIcqy4eDKGMbX1Ubc8GtdAdlfz7L2WFPmXrjZ/k7ruAC5kAk0nsGj5PCBuejHp8b+/UxtI9SdsVCH6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZfBMFic+30Nwj8jSk849yu3Y85XpOEZeum2wVZHt40=;
 b=oMlw/96/M5UgCzFGjyRiyKaiaRvPr2u+QY4lTycLjS8DTj9P87bQtWhS7ikmxHY+Ol/TbPphSAzJfVeScQotS6NsCb3q0wvBRnkhANMrgZySCY8XCwd0uqUmx1HzVX5DC1nzstuQ/gjX1jWwVdjNUF/13cW0DtgD80bDT54F9s+93qNWaw+HW36BHJS3JBoju5179Rzh53n0OrKZ4KkIA9NkBoMt2BIy38ddpxtU7f4EbRZH0Q0vVXzSj2LJsYn+IWcJie0g8ktCBTRU3YvAjWdL7xgBXDu3ja7T4fVmgCXAZmHrlWIgf5ZBpTwYYLROfKuYSo6H+OZifBDD2UQI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZfBMFic+30Nwj8jSk849yu3Y85XpOEZeum2wVZHt40=;
 b=X/Qmp0qXRJoJ8nLP91pplKknOZQBlr9BHhy26/I2CtO40vcDyfGpHJGrJ05iQfaqKcnzIzrTIHgh/61TtveuCIkLoi24PUeb6Kt9IwsqJ9gh+f+w3KKeCmHvHFnozqkEMIn7568YDC+ETeyGdSbGPb7rtARyXxJ8vN8fOzC5QbCD6nvNNSJXhG4EWW4seFdnTUydDzf8iNg0pm5nzwywl8NT6GH7aCebL3CM5Bfla01USrlGXKyXdFQgVpXKMlLLKXm338nWvNPBP9XZhGyJ6yBReOPQ28IMh/mJcZf2tDO+2UfG+ZAknv0jV/9VZP7HZsnkhwZfgdqfGUuAfroKdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3906.namprd12.prod.outlook.com (2603:10b6:a03:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 16:13:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 16:13:53 +0000
Date:   Tue, 19 Apr 2022 13:13:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-kernel@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH V6] RDMA/irdma: Fix deadlock in irdma_cleanup_cm_core()
Message-ID: <20220419161351.GA1245221@nvidia.com>
References: <20220418153322.42524-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418153322.42524-1-duoming@zju.edu.cn>
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca06aae-ff38-40db-eed4-08da221f98ee
X-MS-TrafficTypeDiagnostic: BY5PR12MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39069C4F22BFB074675CC1C4C2F29@BY5PR12MB3906.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nxKc39tGHj0V3Gtw4BAOLWVVuiFjMU68+q8OvJSepvgmNk1jHTusO1DP51YcKoWkbNHB+WX02+aZbUhpYCdOlH60JDKokTA7CDgswZx3kV2fpefEJkPa2Li52x1vpAf2cynoNLRx+OE5I7Z2XnobTVYOWaRtLE9osTMKL2bKe6vdApf4SpEz6V5KudSCPgYdx9JMnYseddkpog5dPc2FJ/RghioLsNb/ZoqYNQbCh4Emc8dFYQKtoexB/pLoyAOWVmi04hYo5/PaIW0WlBJbg28MWk8msLq7V/dH6T+oJzqh3/3Blq4VYbIa9wF1GCLtVc42s/OAngFBxBQ6EhTRqDhlLZoprTeXZSTXIGPVEJIZ7XsEHPGAnsCWFCKwtrEqo9Bw88EmVlXzTmzZhXv9YgCJSKYPKu0V63vVAuktLZ+nTq29V51C8yWkAzKZq/lrPCMCjaOIsUbgC90O+pPJwlDT/y1u/II4StMLJ5A0NtWiSjiLqS3HAtFLwaLaqamwaf2MnJ2BMtP5xwSvKmVyR6dMx1BHVa5PMdRyxuyc1Hn/nZt5qqHSXhn4N3qrFeqsvHNCKhMYldzhGKTbn7KbCM5kFWat/A411G5WovMiRo/riB1Bzm/Hs99oflhi0srNtugCqNLW/7OqDn83rj7Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66556008)(6512007)(66946007)(66476007)(38100700002)(5660300002)(4326008)(8676002)(26005)(6506007)(2906002)(1076003)(2616005)(186003)(83380400001)(6486002)(316002)(508600001)(86362001)(33656002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psxkiicw2NAxWvaWj6Vp508/NPehl+D5rINOseGKIHGIi31SDwGr3dCy1B/x?=
 =?us-ascii?Q?R0KZ6vHCWZLzF2jmjptXceqN7QWyl1p099r0pvXhezkgKNjaUslvlp3RvUF1?=
 =?us-ascii?Q?cmOn+MzogDs0mkOGstp+zFFk9dSuTju6RhxslqbDLARBJDWguJVPQa9W1rkj?=
 =?us-ascii?Q?m+HO2VYFcF7260+6G1sTxOOZvEMadHewb8BHvhH3J7tzEA24Bf0JrZm77ChL?=
 =?us-ascii?Q?ns4nDpNWHmsmb99/wxKSnU7bJs8aZ2OGXQblBawp1Vw3i6QjvoOVBkN9iMyc?=
 =?us-ascii?Q?yMEq6lwaDVfDAZsXvLNxQfOMlmC0V78QAdnTt7ZR8vphATF+s/yH1Se7pX13?=
 =?us-ascii?Q?aPOHDp6gXtDQJMdTdgnaS/ytpdrRQcwDwOxVK7AcOR95g9ujxxNX/Mbr1YE3?=
 =?us-ascii?Q?IMpOX1dWKVQWm/FLJyhls4uj+Ahs+5B7QTSdhdEGFCJ5TRpsTT/Vcj2akFES?=
 =?us-ascii?Q?qqRj/c41xvCYAgFehsOjqfVCkfJIsfgkCp0WWA6pHmYIG/8uXrPl0NeU3wr0?=
 =?us-ascii?Q?C5+5XyODf1I78hU0evz2+01MZumsflWNf/eFD9TZMJSYKqz5oDGI2N5CEsui?=
 =?us-ascii?Q?G5BcM+y17sa7rwZj4lW73uALm3Mc1EquqK+NC2FVxPHt44CgfT8tVasfZiN1?=
 =?us-ascii?Q?Ls3/M/MU/6oN5tJclFgs+jvJLJG+MU4+SJEdNK7uApi7YnQG050MPs6JBf7a?=
 =?us-ascii?Q?3+XCppXe1wCz23WSlbsHbaji970uYGCDMYFYwfeuxC/d2fMa3ZfM1/0WJGGe?=
 =?us-ascii?Q?bz6R0XRV6l5KI7i8Wybb5qcrvBmGpY8yhdnia/6Tqx5cT49DYFOI3FW1r+7R?=
 =?us-ascii?Q?o94edEcgP69z0MQiPkAs3v9jFbS/2CKtUsYKKjtuRWHOvslqf4GVnM4fZnMQ?=
 =?us-ascii?Q?02TVu4NjiD+Ert8+Gx97IO54zy2QickxTAGKY50aQA4QxAD7BBtrpLA7t8rk?=
 =?us-ascii?Q?4svE+y0r11IALmKi9j2J8wOW1tvN3s10YIztJpOrw2/omxCsIM5lMBT3BJ6m?=
 =?us-ascii?Q?dBJcwOBMqyy+EitN3W8m7EJtfk3RXUUuVkEFwdDFZPb+BY7OumJ1EtiwigDG?=
 =?us-ascii?Q?aELO0sT+Gh5ywsaP0z4GrZQ0GucCtsP9vAUPI5QJVYtBtkvTzBweAgebSKj8?=
 =?us-ascii?Q?PlttwTdY+XoCuEPURufX48+GIyuYmA1QyusWkI9LuZ4p14g04SxVZM6h/WNp?=
 =?us-ascii?Q?RXQwj6k/1TxIgK1MG21cAO6bAo4/OmRR7fGoikl4ldV9D9JHAMR/Q7MYAKWe?=
 =?us-ascii?Q?i3l3X6Gx75jzsQGEatB9AmMyHfpi7ig1WqvbYctGPbd4StJZHA+pZFPfSeTD?=
 =?us-ascii?Q?Bsna+gh8tTGXiNmODqM+03DdMnU32a4CycwiMlCNONg1iemIC+BoEVJyWkWw?=
 =?us-ascii?Q?uXdfgjHyMhTWCJnDVcEqaeiD8MTPkw40M5OwH7UWzD8T6XWGqpq3wNj+EROT?=
 =?us-ascii?Q?S+SFTPGqnG6IBOWwrYHH5yHj/fBg8b6+X46wCTPdmXgxjmBUAGdBsTCXP2DJ?=
 =?us-ascii?Q?nBGdYQYB81sKnkFxK089IihyAI8MXQFAFV1yXqALjYc5AxzaYoPqEViBNfqr?=
 =?us-ascii?Q?TFFhSoVJNflnTkQwYJgVRwTjdZlqkceaVGd+heQeaqRBBHh8naOorirpOY9i?=
 =?us-ascii?Q?lnvx4cMNHlrT3581Rwc6gNqWItv55kaPYbg9Q+efnEIiU/txN4gWuWs/GxDY?=
 =?us-ascii?Q?wokFgUjMYVhpZcq/xZemGjv+BGScD74esUYuY8kq2o6Ei1qpqInmOjYs/ml1?=
 =?us-ascii?Q?I+VCJb9woA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca06aae-ff38-40db-eed4-08da221f98ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 16:13:53.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O43KGgTL4BUNpV6t7m/5/BLV3uTGncGMnDtk4t+ycgdU13ywEsu4qJjpSGuiyh7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 11:33:22PM +0800, Duoming Zhou wrote:
> There is a deadlock in irdma_cleanup_cm_core(), which is shown
> below:
> 
>    (Thread 1)              |      (Thread 2)
>                            | irdma_schedule_cm_timer()
> irdma_cleanup_cm_core()    |  add_timer()
>  spin_lock_irqsave() //(1) |  (wait a time)
>  ...                       | irdma_cm_timer_tick()
>  del_timer_sync()          |  spin_lock_irqsave() //(2)
>  (wait timer to stop)      |  ...
> 
> We hold cm_core->ht_lock in position (1) of thread 1 and
> use del_timer_sync() to wait timer to stop, but timer handler
> also need cm_core->ht_lock in position (2) of thread 2.
> As a result, irdma_cleanup_cm_core() will block forever.
> 
> This patch removes the check of timer_pending() in
> irdma_cleanup_cm_core(), because the del_timer_sync()
> function will just return directly if there isn't a
> pending timer. As a result, the lock is redundant,
> because there is no resource it could protect.
> 
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in V6:
>   - Change subject line prefixed with "RDMA/irdma: ".
> 
>  drivers/infiniband/hw/irdma/cm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

I fixed the compile warning.

Applied to for-rc, thanks

Jason
