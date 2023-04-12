Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCC6DFACB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLQFX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 12:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDLQFW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 12:05:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B756A48
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 09:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+/cOQ+mNpEFCx3SSUSjgloJxzKhc6nmgY2i3PlK1tt4a8YdSXdKcyS3nuZKDbj5Abyf0I8v2SOu6Kx56Sd7aTUmyf/8XbkB+dRizjai/9ExWto1hry9rpKP9V3hgU/TBhF09nrPZGLQkirZHx2CJXUtPKSg1jEpgZjXwJPLfv8l4IQ3GM6V8fvzscX6iRFDUKO91iEllJEB4rQ4WjY+yOFfuHTSjEl9UwPPIlcuy3XoNR1e/wSrnzpcmx3cWu1qwsfc9b72WDEy7ZoTpEge/eEvc0GGfZwAuQ4HCRK5ZQ3yCRh0dvziHsaFQVD2RKUq37WutFsDsTW5Wq5vV2EquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGkSVAugN5kxEBhHFBoekNSrMm0AYQe5Ykb8q/5gBw0=;
 b=MgDMuyzLQFXAsX9JDac4ASbSA2BemvXeyp9irqVQyxVmiWzCQGYX+MncnKFVx6IbubBPKqf7CjyXc+CMJCzXq3eKuHZla14esrOltKXIAvK14KRJ+kRZ0QD7J82KhLH7smyr+IJKxjFxrc6e9LQIRMT1hVKlDP8kYq1DZ6PIdg+Dz9wg7G4bgVIClEkQcaBM+Ol3pg7jf4+okivN/q3Smz/tEK8yLS8sIwLxnDCAhOaXIC36euqXRmL0uwKby9KMUQMvX7/YHr482yk2pU7P/+xZehwKx934HNShQWZTnDO9RYpUy4tHu9DLtyvP8bQSYvsvbKKLLmIo1XumYytRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGkSVAugN5kxEBhHFBoekNSrMm0AYQe5Ykb8q/5gBw0=;
 b=QJ5RXZjgM6mwGzEnmH+qwmt8iEwEzUMwoygcVSBnqxFU9ge4SSRouMIVToFIQAgvPP54D2+6r5qKHUFHs+Cgdxam2HVVeGTIJGtpENKsrVg9cFOcITfcXU9o3zstZ1WDO0tojENErZmSZLcw+shja1uzVtAI8eBeZMknWAufH83F7rYXOMg2ZMHqiLmIx0nlE9+3MrvECtMYAXy/aB8ZZ3fzRL/s/DdysUPb1iP8q5GKu3IAosEvxVSkeA0rq3KTDGD8Tt8+KOcrlT8QhXFCEGdn/Wyf+GzqOGMPj7qJRoAnI4zb8qGPcehEQN06xFRZVPSQ7apTDVMP3msZexlk6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7288.namprd12.prod.outlook.com (2603:10b6:303:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 16:05:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 16:05:11 +0000
Date:   Wed, 12 Apr 2023 13:05:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/1] RDMA-rxe: Allow retry sends for rdma read
 responses
Message-ID: <ZDbWtUMQGS3q1GSU@nvidia.com>
References: <20230215224419.9195-1-rpearsonhpe@gmail.com>
 <20230215224419.9195-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215224419.9195-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab21dcb-7795-4723-06b4-08db3b6fb1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXnTkwUuD3WksBJRITbuDIF9IU1SuYBOXeetXbA+FzuCpauyp38eIfJGzNG4ha9Gay1lU4H6KNthws/CtefWsm/WQZOUpT6/qSD6LU6eJJIS3eCgIM9MTjx2h08p0bbZuY9lOh9/44xQsiDupx4bidSmvpO0l/L7vqPVgBi7UULtD1AtJil/eeL1c0gCZRud0P0GULy+Zj37XubkR00bV0TkwgSiZzjRcuHNLVpvn38QdhjZM9jnt0g4qT7pE5mxvq+0ux94QI1RBo5ZXWQhN+eNaURnBrW6HhW1aqKa4QhkKJfcHGmTrZnouRtNRFse03tOWKORhfGb4T76IRZDehXIggrMfsp2aCCu2WYDDAkHoqHdksG3tsWsABp5Fc5Pp4ttogTE1IZjeSe1ckY101d8G2BpvLAPqIKUVfdF9G3VS7UckQViMzz73GhSLlfxHVTgSiLlqruw1Iq6Dbsmo5AP0oHEAKwN3v+RzR2IfTXxvbtl5AlIgiXYJT+05mqtru1JfiYKdUi2p6/eyp3kqJs9jyBrMmt17vMAgnGDej63sBYQQQnwRwmHDgbO2837
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(478600001)(26005)(6506007)(186003)(5660300002)(316002)(4744005)(2906002)(66946007)(4326008)(6916009)(6486002)(66476007)(8676002)(66556008)(8936002)(41300700001)(6512007)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Da4wJXJx0K0mWdac/QegaUiMgj2uyndMfpE8mCccXAWK3YMgpIt/LbMWAQmN?=
 =?us-ascii?Q?/2tD+Qzd7vAOHWgLcEmVmdOgNvTeaHVeuffmimZsQUHBgJw7fgVLyKkOcOrI?=
 =?us-ascii?Q?VvDjTzsK3lsSO949USfovrtqw9g5vOAMJsuKDlw/h1J3/tcA1akbB2QGYmw5?=
 =?us-ascii?Q?9Iz/W9Yq0Sh1li+X+4C/UM2vT3wygID3+Fipv4vT8Ywmp0X1SA2vU1NsXz2g?=
 =?us-ascii?Q?cB+5dPW8J+zBn/OBs2oe959rRMvsiQ0xLp119y5vuKbZUHh6qP13cS2N6Z5d?=
 =?us-ascii?Q?P1pmPv33V4R4C43vVD5QeBlEEhFoU/zBItDmyekHZ/S90cNilWnY+Q4ubKmM?=
 =?us-ascii?Q?1+uLjnPRZmzYdl0DXw9X2Y/t4F5PAEB393JUGhErSUYCwwNqJ53UHXhcB2vT?=
 =?us-ascii?Q?qoLvySCd4lbd7z/9ciT5FD72gcoC8GCOB+lXWUnr/B24+ojX43X3ALN3uii6?=
 =?us-ascii?Q?4cLCNvyaAM0t4oI/RBKLzuDQ0Gxke7qJZ8/BqRxc2BMa0X571n6PRuIIGhc8?=
 =?us-ascii?Q?THdm24E50A23U9Bjj7hcfXl4rsBPpUmIZvZ+DFnLB0Z5AUCqOKNIBo8yAinv?=
 =?us-ascii?Q?t0dJ6qN+3q/XQARegtwAU4IrL/35ieOoyF/BLoZOvHYTeHXmBCWql9Lu5LZB?=
 =?us-ascii?Q?3jqel1yr1ET6KM9YbCXHqzrO8ZgTkwuUBplhZZGBcM9DlyyAEQTT5MZ3SF+Y?=
 =?us-ascii?Q?6RIlhk9wjgg3Dre5fJVL1YXgYmaTOtwxSA87bhdGCKlIRa047HpUNn2Q1jmh?=
 =?us-ascii?Q?d06tAnfxRUd1qvI+lbdhcYwvOTIC9VWKL41cqg7QjxTFKBHYYafthGeQDbun?=
 =?us-ascii?Q?30WQIAH7iyF9CbJznsdv5ZjQnAtLjd85WJlPkPo9NLaXjL8g+hwOdaPKPsyt?=
 =?us-ascii?Q?1SI3ivVeX7eEpbbaYfg5NV6e4zCPQS21CpbwFFELVWACwQ08FQWjaiyYAlE5?=
 =?us-ascii?Q?10TABA/E0en+P+S+2LjGycG5Q5VUbIOTBIEwXIscUou/26uORRoAxph1EIzL?=
 =?us-ascii?Q?7RS/MYdfqqJSkvA1O1jEPWpcORcV5+JtzxsNAPnRaduWrPld73dcoJzkiZuo?=
 =?us-ascii?Q?4whIUmtALb44Q6LsdXygvRGpJUxIdSMDlYSheF3FRvPGM4q7+ljx+Rj9AQZP?=
 =?us-ascii?Q?7bVsebHOd7gfAo7mx8YbNsK3GFRs8gdORFDUKogoBXsLVZDiGpnbJYfcMusW?=
 =?us-ascii?Q?+PdLlEP6OcZfxIihRKkQTqgFfyGDzySpOkTV2G7Eivnc9QWtLfmmV7IVoeUu?=
 =?us-ascii?Q?owbgWVXS2XO9909xen1fy+PL7BN/klDSuDMLWBFntzYgRsFMtFruTWQ+UgS4?=
 =?us-ascii?Q?UgL/G0zNgZJ2GgHOyQyeFnPhodZXmBJ/FzNUfLIysU8JjM0elTqu6wCYlvay?=
 =?us-ascii?Q?5Qb3q2xmMhEVdqKebkJG6Q4SiT6zF0bSefeEak/AqqpikKl1tPsqp/oGNh6N?=
 =?us-ascii?Q?lX/aTxWN15EE+LTV+ofrGAD0nCGo0lerp0sEIDV1HRxtZb/m0ChBuhyyUOiw?=
 =?us-ascii?Q?QNnDnoHY7pGdi63820v3rwlg83quynpKY5Drm6dJXq4daPCgmjjlsdXNj9QO?=
 =?us-ascii?Q?gvYtkJk7kr9T3538AFndMjsM+QdUA5ZWkIlXzMRx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab21dcb-7795-4723-06b4-08db3b6fb1ee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:05:11.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d/DMxiEdSWrZTHETjLGtJclry2ZtBy6IDn4sMgBzO/kbHBoKDjUh2dgCWHtEfp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7288
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 15, 2023 at 04:44:21PM -0600, Bob Pearson wrote:

> @@ -937,9 +987,15 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  	}
>  
>  	err = rxe_xmit_packet(qp, &ack_pkt, skb);
> -	if (err)
> +	delay = read_retry_delay(qp, err);
> +	if (err == -EAGAIN) {
> +		udelay(delay);

I'd be happier with this patch if it wasn't a udelay here, spinning
hoping the ip stack progresses just feels wrong

Can't this use a timer or something? Re-rx the packet generating the
reply?

Jason
