Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421CC6C3210
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCUMya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUMy3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 08:54:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3F8A72
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 05:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHcYnC6Zvdc843mBZ5SqZLsvIuMnH5fNWmtGaGrgZMw7HjTL/r4ua7tSb03bEaSKSVLuvM9FgTsSLc9PQMVvTKQgqdJyyGoV3Lci5dew4tAJm1iaaGBx12e1JoEd+h2wktDPep8aev41U49LPovura+AEHmSV6UcVoTA4CLkq92QAiPZfWJDdQlHM6u+QILZQpoNbGgLOBNfEpo7PCtpdJqF8PTBPijkiBif1rM30DmGX1woR4tq2MHC2U8/0bZyMHq3KeLNklesOpydu1Hfzxkg31B0Eih1TWqPxStneJyD6SAbEygYBsLNsOl7u1x9FCzUhfsdLsO7oMo3qnJLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF0cLJzhpeyGvtp3zVrWceGJUnQtTPmYKsH7hIb04OU=;
 b=VSDafa3mGK2ujwRSQSG/awyk+65aIBhGmwPyhoNvbXbbvqeKP1E4aMVKaD05Oyd8cifah8FIxaUolStTmwChB5KSgKoq+npiRLkFMMoGZKd2IqkJKmIfecmGhNmyKAzSTFTZvkRcMc7GVEj9SaKIJCHUj0uceqAINyb2KFi/lDmCDM9ln5KarFMX5ITVyoepnFnMvW0RlWzADogSYxNOoi4aVsBRqjwcPADka9PKkZjmzb5nneJXtSzZKH+RPhvYERWq/s3DT3mV2Jh9XwduPExx8z7kCFwq/2vE7kPEwWWGcXIX/cC3vvwGnI2+uzf6teCYCexru5jmWM3eZwZ8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF0cLJzhpeyGvtp3zVrWceGJUnQtTPmYKsH7hIb04OU=;
 b=I2ZqpsN1sMKugZ0fKZP9rylDGw9+biEAbFtnhRJ9g69hgz/HlsoIyYUOyoAfTZxUWEEcZH4PNajk6CH77SS9EKYLxd4F6ODaAl8Qr47MMahX7b67lEfB0bYNm2aiJU8zCdIaTTEvxHos0KBkXMnDETYzxi/M3v8QQ+vKxhTkMfPG3OIRm3PrOwIsfLVOQkT0EYCbK0aJii0NZGbdm0r0J/nHmSFmpC4dox7eyDTWKVAWBwGrR6y8nclKBTkWc7B/VTMzM4utQKNfhWqtRGGbLnwunT1lNlqTPQNdttBbV/YT09kbigjRCNSDmyLFk2mrdnBJtew+LWr4cP9lHhDgvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:54:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:54:26 +0000
Date:   Tue, 21 Mar 2023 09:54:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: question about the completion tasklet in the rxe driver
Message-ID: <ZBmo+3s9herDiBR7@nvidia.com>
References: <d61963cf-77ef-ef0a-8c94-2de89cb6a5a6@gmail.com>
 <SA0PR15MB3919EAF4C949E82D2887C1AA99BC9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <3d8576fc-eab5-c962-95bb-badadd18c85f@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8576fc-eab5-c962-95bb-badadd18c85f@gmail.com>
X-ClientProxiedBy: CP3P284CA0009.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:6c::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: 67320183-cf44-4bf7-80bd-08db2a0b66a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT3a9EKnSjB0AZOA5UH+yRIjAUjPV24VjM8W6SCT8cfxd0Y/bfmqZx5HzisyYgIzH5NI+yL5eJYP44oQzomeNoXKka0RKBOuuOQ/KcGDqVFvDfmIfBnpkcf5tZWkewWY2fumW3Xfdgib6MdVs92IQYzjnstdpQYh2hyZLKYqVeDkoPFIgu3TygcDaOb+AxZf1k/7Ldx05nEmJ3srvW2oLkEZi/0dZjHH3IBUnH6oBbrvkX3QmTEyL/6kWh6hcHuc6GkkMLODdMwX5Q8h+fnsDuHP8lsGsnlTn7hHfKqdoCp3WbriARyWjh/nws+lClZIrShwG1/UkKPwYc3llf8t4sVfiAgB6R0XDkkxPIPq3sLvgPtx1JDkb+r9S+7/jLvB4eTZDXpODig5fn0DxBO6sdlPLOXh5YzkappGnkcbPI2OJ2qOs2XNMkiOYF0NsRfW16eWsz5XwWiU65z7VgPjmUmVlZixIcWpduWioi0ierVIb/YMEyKT94S+rcnY6T7vnPwEa3L81yUMhjM0uOD0MAhN0BdbLRtWtBEcnytKhWSEKhX01qeElxxYDGGoR909YEMRSaBcXCWdPlJOorHqBODbCeMVz3/oiiGb9Z1dVubPKhejRMnHs1Fdgd3Mzr8xSzeYn+l5YMSZMT+/fz9yIPVSVd1C2CcstgTsEQm0J1TEl8W3IoMT7FWFO+vZ3UaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199018)(6512007)(186003)(86362001)(6666004)(26005)(6506007)(2906002)(66946007)(5660300002)(8676002)(41300700001)(54906003)(6916009)(4326008)(316002)(66556008)(478600001)(66476007)(8936002)(83380400001)(36756003)(6486002)(2616005)(38100700002)(4744005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9pdKvQy5jYsrnhrRuNe/BtctZTtx/8vYGuCpOYahP5cQO/r8hhih4HpBnw/?=
 =?us-ascii?Q?KykSD8JmthUQ7kGXH7GsUyZ3BFTo9ND/3+tYQCSkZIEDqeUay/ExGOWrmH5L?=
 =?us-ascii?Q?JA6q+2uwZLlAkj/jGFDN27Dn/I0As4WTXgyX84NlTnP5e5H7ZBSJuoxamX9/?=
 =?us-ascii?Q?cok2EHEOoobjD688qs0bLiReu8r8l9qtKBBm9cqBVnaK0ob8kDLc/eP+Iql6?=
 =?us-ascii?Q?GdcIpadnJNydBiNFf/eJRRgbv5aaBCbF5xZZBecgdeXwnJG/aazmUUw6bAzj?=
 =?us-ascii?Q?Hnd/GbHnEUiBEX2LdagbCtjODVeBI7dk+WAUkrskSKnmM+EWlFP3+MwrIOFX?=
 =?us-ascii?Q?Uk+MsC31DXL507nazYET2r7g4gAcgNsYpdClMqhR4rbEEDFqLi6fOtsaXw7y?=
 =?us-ascii?Q?FhXytMuYNSC4ylE3z2jdfdkd2YULafTuy88gaAhuiq+YC+hbeLeqZLmUhvIK?=
 =?us-ascii?Q?CFPCI3XVIs5BY6rT04cNMO6zAp/Y8tRuJUVE87plNSXPYCyuScqW1KDLwaOp?=
 =?us-ascii?Q?o6v4+BPZWPnNtqcND31lnnrD0NsSPSjbIsSAuGQhhtFCyRJ9/O0oBfuz613s?=
 =?us-ascii?Q?72vcgXyStvZ0wTzoyGjrj+xbWVxUoTQFRbSqbcjMMsGjbA1dbuvsnjbVe+0s?=
 =?us-ascii?Q?E3kSIdRtFCzykB7NZH5p/7lDUBEoGON0FTbRBKObfnVMaUAlbUMh03Aba+43?=
 =?us-ascii?Q?/WAH1zhio2mznVpGUz+2cg3EkvTYeHekId/utgeP+1tgs1Morp7GaSshAZtA?=
 =?us-ascii?Q?9Mx0xWuomFz/aQFKsnyAQw2gDta/CasWNVYXKFaVgN/GYMtzQEFknHZXErxs?=
 =?us-ascii?Q?cuE81MnEL2LlNSWuPBIAg1xM2MkHBlDCZ2xUh38SRtJuTWZp4PmldODkgr7h?=
 =?us-ascii?Q?FqOErHmS33SI3qSP0wtoMI0tjY8qIpHO3xwVIoqGWVelACk3q5OM/4P0qQ0Z?=
 =?us-ascii?Q?yAAE+BADVYpE+TDvlxsXw/hqb7tHBvlAO4NsTTCfg2qFyEgyYCFQJeHvrhl2?=
 =?us-ascii?Q?iV+RpoJPKOsL0evg/q6vlOMuoCNzrRTO31nqIPFRwJ1TQlFfeI5swpHrTGCD?=
 =?us-ascii?Q?Cb5JImlD7OdTsvS7trgvKeE5rWC/RB9ogGu8+2gxBNG/WAvAN1Mi7OsGqM5d?=
 =?us-ascii?Q?ESajRdpmmUsltmyKPcI+qcNzwrRjvtXSq5tWn7uCayUrjocA7j85LzeseCMd?=
 =?us-ascii?Q?kDLeGx9+hgBvLG9H/1zq+NrdcV9SVEo49o9wESjKwbAUf7CDoH3nXzCRePgM?=
 =?us-ascii?Q?G9awrn91vbjRF3TnGCmZ6B5fxxRKeT5/UuDiloGi+PNzGfePOj/RrWa6tCC8?=
 =?us-ascii?Q?LzJDzXaqsmnFg9ZxVmazZiAjULq8p/U43KsgvahhAbaWhpo/oqTFy6JIUZT5?=
 =?us-ascii?Q?tljRIeACXXAEy/5kkurU+pbHF5qfvwLl3sW16Bh7SHw0g9FOB/NsuUnGXY+k?=
 =?us-ascii?Q?7HnAwSdBOmYDpGLGzVOP/cXSN6FKyb9pDhyW+4aTHu2j6SAOYZC9NR0h2xi1?=
 =?us-ascii?Q?mEMLaGYAJV6gLJ2eFb+uyv10tLe8DhOAogWeLf0a1lVqcIxkAEpwPZgxSQ6j?=
 =?us-ascii?Q?m/KWPMy2QbpqLn4a5p564AkBjRze9kGM8MzNbqiI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67320183-cf44-4bf7-80bd-08db2a0b66a6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:54:26.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEvQgShLcRqeyCWvhDbP9qTzsYtGqvJxm8T1NCRIEKvBeeEyMST2gT8I5kIF0hCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 16, 2023 at 12:14:30PM -0500, Bob Pearson wrote:

> And you did. I am not sure why the mlx5 driver defers the completion handler call
> to a tasklet. I could be that it gets called in a hard interrupt and completion
> handling is deferred to a soft interrupt context. But for rxe the completion
> is always already in a soft interrupt context or a process context.

mlx5_eq_comp_int() is a hard IRQ context

mlx5_cq_tasklet_cb() is in a tasklet context

It has some logic that it only does a certain amount of work per
tasklet call and then it reschedules itself to run again.

mlx5_ib_cq_comp() is in a tasklet context

Jason
