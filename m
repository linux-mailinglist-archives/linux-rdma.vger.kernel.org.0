Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C454DE0C9
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiCRSMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 14:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbiCRSL7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 14:11:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DE52EAF7C
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 11:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR6PyGjYmBY8SNS/rNmIdnVzd2/KkhpPz6mcSpYxwCIsUFQPipiMXSYmMpYSVmT6Ju/BZYsQtGRfmWp6IWAJSDJ/IAeVVezVHiFoX4Eyla3tDkyfExlVlZl8Lw0NCIFUA12B4+D4AbEXWJj+p3b+iigX3IBrb33utsaYFs56LG06TQqhovX0os45UME97HkGTiLGV1EYBwTdFvbRYejG5tuNHTMyeVfhy8R84HKNW5z/HFKEPQwvgfMQD3pKhem1z7rQyb5WruVr86W7RuFb7oGfG/Oqe6FszWmz+Sdcz74gtcqsaaZ4MzLqovPblkLWUok78Rx/Oq9AgEhrlLJCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/DvjjqyPZ8jWIHwrWEoPv7uPOrtI/CFmAqkjBdUqrU=;
 b=BbSgP6jWhG1AzzRzvAyQjLZhVysCg5oktViPTGAVcB3rZjWPhJeMaXZWX49EujIr016jNhiuE7iyPPbbO/TnxP7Ydk3szPWpYDPaJ+FjzSEiWpFA50D7eCxbxvYK8/0xs/865/G8vp/2aNMnkAyIGcsalWor+qL3d28jWalzh7tCNKr1s0le8J+LfAIC4+IIgdBk1+q1Isj4ujfY/qlRZEhAsCWNJku17bRqbQRUWwqc1VZ6PAR5ANsiH5FugF9LGwWy70fkodPwza9wU/hNuAVrfGZ10OQ9FCHTEcBFQG96pPcy8pNA4/OjZJdS+Og1HKAFpgMQ0yKf5dcBMSaf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/DvjjqyPZ8jWIHwrWEoPv7uPOrtI/CFmAqkjBdUqrU=;
 b=S9a3mUbftvjuA8grH1Kfv98oeKh6QzyhjC5sa2If7tQKthSTC31oYg8VpUtwhlE5897pcTlrdBfYAvEefugYWxbJhxXS2QUuW83ecviizkQDxfKrOIPvCUoj+VA91KGcpOVIJhDjgFsZ4Ei3oEcAICLENoDy2AE7dVvFyiWosoul+nmP7dlsTELRnG6t0TLKl5U+8GaxqJAPFEm4yrO79EUaZUoYjEvKXoWw68arH3aNr3oLVzt7ZhXaTm60xIZTXQaMToMrMLZR1TcdF+tbGJQrfMFGJuHrn01iWpn7fe0EsDAvEh5muqFXjLrV8y+SJesb+UrvjUQZOrbfqwOiuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0102.namprd12.prod.outlook.com (2603:10b6:910:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 18:10:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 18:10:38 +0000
Date:   Fri, 18 Mar 2022 15:10:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 09/11] RDMA/rxe: Add wait_for_completion to
 pool objects
Message-ID: <20220318181036.GY11336@nvidia.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
 <20220318015514.231621-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318015514.231621-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:208:134::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff98dd64-8f11-41e5-1509-08da090a9aca
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0102:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0102FAE84355B3F17D274F97C2139@CY4PR1201MB0102.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZqV8ZGZxVHU703JDj8MsKNRpn1kClunznIFTYvoIewe15kUcdUvsNL0vPvBSIYAzlM7oIt/SAllSIrjt7XvmhuPAxJuEw+T3cNmnh13ZMxzIHHoFzg0xxkACbd6QAw1H0QAw8/jUKRwdmuD+cxRZ6mePdOQSvvaYWmUP0u3yPMb0VnEIGgoY3bJL7ZsAU8MHFcpkQQ0Ct/cZilam1WvUjzt2jVM6ZpKqwuVq6sAxjNnnZbC8tAFxwbebJ3SgNquMPrROwtIJ0W8a+CV6ZmIwCeKV7mDmtE0OsqnzCcG1NkDEqnPEbuBF/S3FyII2+80KJM4qkzWSod+aao/JrqiduN7E+nSuwvOlv8PjmzGRyaaIETcujRgpncKsw08tp++EuRUtvvSQamKqs3LiYCvX3jgK/wjNTBiyu4QhSI5xcJhwdcd1deqFNPnmuaafiwF9b4/Yw7s0arAADAeQQgaufqtMnIwu3zW+f7Ne9KyLmOdeYc54dh3djQHEVCRm0y/wwp041RVgbM9PUlE3HlIYeUSgNgXQPCiaHRj6pOaqEVbd9TRuWrBvUxq2z7Efmmp8Icx3g4w9Ov12n9n6ftW5jU5iO4MSZchiYuNPFpr2pSeJOX+j0fX/PnnAwdy+FK5H4vM+P72bojQppJ6h5fvEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66476007)(66556008)(66946007)(508600001)(6916009)(316002)(6486002)(5660300002)(38100700002)(1076003)(33656002)(26005)(6506007)(6512007)(8936002)(86362001)(2616005)(2906002)(4744005)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcyPkJ32CMUxTJBiXmCnR8sLEhhSGBG8edgosj4wGIyfE+GUzcvC/aNXKuPh?=
 =?us-ascii?Q?TWILqmzkxfzOr/xxFR3ptX/DV8H7FvMzqGrWMxEBwvcmW8I+8mzRkywlsIdu?=
 =?us-ascii?Q?eaB7eLDrme7HMWHLMAGcmm2SuibuQ+Q/XgFs5zgTXm69b61Dqfeyo3mpjgGR?=
 =?us-ascii?Q?0xPZY4ltEbi1RifJ5/5QX9yiDwcvz8Fkv8T6v6/e4x7KlNOu+xtrL4EHq3HD?=
 =?us-ascii?Q?M2Id5RDzemeW1P7JTDtjjgaLQihKscaquGyvSQN/poiKD9tTuvLWvzm/Z5jB?=
 =?us-ascii?Q?5+bqesxqZ+455gTfgEUAGmC3XG7doFOvs0ZLQL2Z3heHf2rnH7GiU119Kf1C?=
 =?us-ascii?Q?zQSbgD14/n/IH0G3z5PgzAFrnmm+UTItIJx+FtDGh7RZ07GYuZhe15zY5vbz?=
 =?us-ascii?Q?yKOKY8hAAVGNtVVcnrL26F9F6+d0VT4YWN9kLdULHQgfEeXXx1bmhJ8WoKWC?=
 =?us-ascii?Q?P0oCwl0ZHrXlZdesGZBw2zSv2Ck2OHYRkEFap98fuOZAbA7Yqw2oHnI4+R1a?=
 =?us-ascii?Q?VCxDV0g95VAhu8xlAUjhmV8s4eZ1cnHv6N2F3XL4OvcGIg9oavjE4cikPo8T?=
 =?us-ascii?Q?NXmsY9U9qVfhqyMEH3ALeRhh213x1KlZy2YaxdjkZGA46dAwDwYWquuDvnck?=
 =?us-ascii?Q?TZiLLE8ZXC8M3HX66l69rgehoHbI/2O61enAOqHbL2USjfpgpKzSir0Dtz61?=
 =?us-ascii?Q?tNs892uHLNMd3g00Jw12KpdT7w0jnzNT4P4wrmKRSeGENqg6oe+b1IVIgk3R?=
 =?us-ascii?Q?O2QwG4G8NAL9islagXuBhJkTQ8vZXfhd+05J/Ug5hnQUrt27IPMl7sJRR2mJ?=
 =?us-ascii?Q?QOKakFbrSxuvOLcK7Z/pjUjD2w/K24qn4uRGe9qnH1KPHXObMsZU1aYXM7uF?=
 =?us-ascii?Q?g1XSV81weYYIU6YZP97Q5vRwrvNbTkc4DHMPFHkSZlsKyVMMCaknbc1Jaalc?=
 =?us-ascii?Q?6fTLUja5xmpQdo623zPiGNA1xAIiyZE6Mw+p3zgjUWyAsxW0I7HsHwkozHW8?=
 =?us-ascii?Q?+R0ImcKmK+TB20h/OZ17sTDU5FqlQNxf8it6XzjwLDqa7pUjLSXDyclR2+Ro?=
 =?us-ascii?Q?oX0uDMeFvsRDyRMW7ZjKIlcqegv0llei+qu63qspZ4+y81PyYOcDEftQHKpY?=
 =?us-ascii?Q?PDkbaL1Dwd4ZVBxiTMwr+zvo7mWDdf9mOOzFHFaztEYzj3HHSEZE0rBIy3uu?=
 =?us-ascii?Q?NniAlQf5lyszBAgVfo1WWylwW8eN24e/35Vt+NhUjNVcFr8pDONe9Q5cXMFx?=
 =?us-ascii?Q?ol/ZS3HPqQ6JARGlZdmUK8wTMkV33XLmWOiCSus4LwXS1M2UGTGn0hv1X/DY?=
 =?us-ascii?Q?e9TdPX0EhtaKs89bsUdGYBv1oaB1zDeBEDsbSjZGFrs3ukjAX1ssk+ZdflE5?=
 =?us-ascii?Q?fHCFXZjK+4ApkqnWQ9zZpNBOxPmpqwAU8MGowHcwcW6MREKd2QxiQM50IhOu?=
 =?us-ascii?Q?44dWBO4X2vxOqDPZt2cTCwAKp8mpxmV7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff98dd64-8f11-41e5-1509-08da090a9aca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 18:10:38.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkiTtNfjKGOv0OfXo067Z6qbVJaU3yRhBljeC17HRTw1kz3LBSeOxDDcTymjNmg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0102
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 17, 2022 at 08:55:12PM -0500, Bob Pearson wrote:

> +int __rxe_cleanup(struct rxe_pool_elem *elem)
> +{
> +	struct rxe_pool *pool = elem->pool;
> +	static int timeout = RXE_POOL_TIMEOUT;
> +	int ret, err = 0;
> +
> +	__rxe_put(elem);

Like here for instance, we could just put the xa_erase

And why is it safe to call put then continue to touch elem ? There is
a kfree(elem) in rxe_elem_release()

Jason
