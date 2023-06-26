Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0893773E17C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jun 2023 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFZODp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jun 2023 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFZODo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jun 2023 10:03:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583FCBB;
        Mon, 26 Jun 2023 07:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMLnD1GFLqSAWcRuVBC0nqZ4/YO+JzC/lQS2BBENCOMcdwi/cRrbVd1mBcI9NfOOf1Fxt3eY2lLcIucI1oL5a7CWQsY1IN849McdHyS2gQXH51+/yb3OaWQOFBE+v3LwlOjtBa4u/wCMiY/qBoD03CNlcSj1PkvVa0/M589PIdToypafRvHBNDjumq3Kj5YKPB6ukpRW4VgJh958uOwNoP+tv06G7VzczEb2neHofGyH3pKGshI6X6MiEgEVses8+fOuCIIANlX6R+DcyaXfq2CxhE4Emzi28vCXe/JDV5EGGmdj+Ijlxb1WuRQTBCXMHcyQ0ZJ2voD6bhSScfYlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZLxHAQAZDC+npIS+lfD0zvBnKTfPnvL+3iUSWufGBc=;
 b=Q5CchK81WsWGOP78AdRQXZI8Ux1yvFyaOxgGnnokE84rVQBmO8KRR96UcKuy1IwUTiCtiX8UYK251JmGVXo+83TULhCq2k8yBT6QsI6K1eHFBYvYjtq6Xy5a4CIUZ29co4h8c/uL3AQDhtUchnzfdlqAnSbXhmGYTTbaBEUn8r32B4S6F4wSPC4KiBtVsBvoRzmLNnfZkDYAQbI0K9lRKx2/OKahOI/p2Q8rd4rPqqtOEPhm7UtLnwnOcTibCbVO2VGA/oPwM3qmohSByZ6kbbw5MxxHgzo3Vj/n7Dss3yYP9s3L6mwmRU4TMjrDY2oqz09Ulio9ERL8ESCilFAGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZLxHAQAZDC+npIS+lfD0zvBnKTfPnvL+3iUSWufGBc=;
 b=Ow+cArdf+t88GQ7FHjqZALCgA8gRW0kVocXolmRxRbcxtdV9AGhGOJwr4Cy7h8bSGHdktesWLZPZlDiYc2ByTOjHm1Ozq6LrJxuYsgnRBZvajhz8j83b9WP4ZBf9FD/qp+GrFT15wzA8tU1vCRTxKs7OusC20FCS4reoUaKJrBqja3eBeB7Hm0R3ISsDC+sK3saBvM87TdNYki/mh6bkCZFmesE2MasjA5yzs1XeBf41fkoCN6+X8OBv1y0kpYu8R0vFBDjcc//xF5T6kM/BZuIRI3N/1gZHxtIcxuaWgGueSctkVL5tVKY1XDqzsOL/bVtw5DXDF74ZgbXs/w3KgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 14:03:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 14:03:41 +0000
Date:   Mon, 26 Jun 2023 11:03:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     leon@kernel.org, Markus.Elfring@web.de, selvin.xavier@broadcom.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] RDMA/bnxt_re: Remove duplicated include in
 bnxt_re/main.c
Message-ID: <ZJmauwaYYW5DCG6D@nvidia.com>
References: <20230626003632.60435-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626003632.60435-1-yang.lee@linux.alibaba.com>
X-ClientProxiedBy: BL1P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 11df72c9-4243-4cca-083f-08db764e2573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZWpB+9meDLzixrLXJxk5qFSq6BDR9pQpTLUywjb8OJF6EFljdKXNJx5h/v+LEfNidZBfipxUKn5U+8F1XlNqas7CuDvPaq84LUCMj892ZWBw82M/g7vJuI7JWMD2dLcb2LkB8O5iqbfHIKHH2fn8J4Rfvzqe8iciq1akdU0bYoB1upo1Ri4dET4yN0aae8dpi6ybs/Eu8IZZb9mzZX/vvcNwYlQWQ31PtTurJZgO3EBxo5AO5q5LfycqVq3zHqk/FuR+TxI0/irvtV8OxFMlPWaRk3mcXYwfbpfbtbHniJr9PH5qg6Azejjwj9TqqQ0Vu5PESIO69ELPYp2p770lNa5KOmQ5Hrr2OVf1M03eoK0rg4XftrGM4Bknws/DndD2Dcjh0ydONKPDi4Gt+2r4qtEyea1kC86seZnM1gM6n+oYmkrDecAVLwzYGg/EgwpPyvWdsZT0sedBelQpBXz5m1Y70SI7t3t2iFAbLCpCyJv4CdTk66rRDcaBUBOJUxpnrWHwTQKgf9w8UnNhQMX6RZvSGKwO8Uj/NjOGwKnJIh06QFiwZWFtD5E4ggcfss5x7SbFEup7cKdXhf7WBX9ijALLwXbhgycpviEWx/hJmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(5660300002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(966005)(6486002)(6512007)(26005)(6506007)(2906002)(4744005)(186003)(478600001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u1fdZW5JnofNc7MAW7zFOLYYiUSldUGiJBdQzDs4P1gabGRCiUQBUR10GfpP?=
 =?us-ascii?Q?xw8cR1pkFcljy3HFU4HgGqwDolSjG/M/O0Zin/78BZWLZg3Gq1syGsXMi9an?=
 =?us-ascii?Q?fPVKXzzR7GjYqjOee7WwRBuVLM+rmuSGOW/nEgxQN23Ilx7oMJSFSioNbb/f?=
 =?us-ascii?Q?k1zEaLhcb2kOYNmTzi/Eq4V1z4chss7NxbltjGgzu6EDO0y0ihWcDwYI31sE?=
 =?us-ascii?Q?WODAbGNGbQ5Bnaw3P9unzEkhwVc9lAYxcdQd5+73zfhbbmpmgIWM9jlbdtMI?=
 =?us-ascii?Q?bK4eFV79SLQyrcI/4qe5lsx8rnGwiZDKcEy5x4v2HSvqNp9IgwGNEm9txnI9?=
 =?us-ascii?Q?XeU892qSu96sdA/tocH08p4oI5HvRDF7E9XLnrAb07JYwxzwagngv0zUTgjX?=
 =?us-ascii?Q?kLsjsrb9IaAYtqwwwDu1AJZezD2eICc9e3vTAjJxgVPLmqSSICsexyaLkit5?=
 =?us-ascii?Q?864OlqdkvEFkF2IJ4ie2mGPIIdZba7MamGD1crdXapvDqUhrkf4kirp1E1fE?=
 =?us-ascii?Q?yXxWoj4mY8ezsDlM28NkmdPl0VMQJOryc1I9LImuggNHsk+nmFzWcFMhxa1P?=
 =?us-ascii?Q?/utW0awsVo77lt8aXFgt0OpmA2TvF9mFq4sBu+RieuX4pKgFRRtd434XRm9H?=
 =?us-ascii?Q?yTqwMME+Cj0M2vrnNhr4HAGmyBH3PEaMS6uDpOnCPqCnO3QlozdvgCO37lmr?=
 =?us-ascii?Q?9RLxITLoiD9clrIp9a2CMS9MqwCESkkza/Yv0qIvqFIZWKh0+jReUF2Dpohk?=
 =?us-ascii?Q?kELsM5se7CbReJA9kBPQ1dnmG9zFqOxHRfLBDkhnGJRDTqCyOroprkJ1D88S?=
 =?us-ascii?Q?9RHApxhXlIS4qS6/gXt5HvbX2Ct8aQIZ72/CL+YP45tlsLOSfpp/ycDQ/Wqq?=
 =?us-ascii?Q?sJM1RaDZF8U9okZb+HGC0KO9+ebBOfifwECykLIys1PKOWy9MApfrgwREmHY?=
 =?us-ascii?Q?dArhBLDYvXQYFmrKS8n69Ys9dF95MCbEE2Q+Flttfct/mVqHzy4AnOqI4cio?=
 =?us-ascii?Q?jgm/RUNuI6oIhCdRGvNAVZCJOEPOEI5LhbLsfvGJJB+o9FHLDy1J+rZG9+7F?=
 =?us-ascii?Q?yLhBLyzs68JWnk4PVPWdg7I9PmYEKZmsjoo6qU/J/S/Dp9MyfLUHXgFglKuj?=
 =?us-ascii?Q?JnHP+4U/el+wkM78jxysIiViJvcXDcRNCCtP3GAuCy2mKQegSkW4I+a8AYuf?=
 =?us-ascii?Q?aOt/OH1y4z8Cep2QDWcWoN9PMVY7ajFpD+IXv+2WWpuXYNRJiQfXlwu9cH4g?=
 =?us-ascii?Q?C5g3qkoUQ9mctjc5Clp+MkWyVdthnJAdJ4OliySmJihbLA0oMX3epRQgVahx?=
 =?us-ascii?Q?nLMyASezXCCrn5QLdB9xk8UbweTgKYET3XHge7N0o2xbyuLUD7R6ZAUCvk3e?=
 =?us-ascii?Q?vsGUBPXHfsaMcHVWl9xqLbwCOINU/ytUQh91wP6IQ639e0dcCOzx4r4LmRUc?=
 =?us-ascii?Q?2uoHn911nf7IhZ26feDd0NJMF8I8VJJwV7UijBQ3ySVVJPDhHRMbJYB77uFV?=
 =?us-ascii?Q?Ums8NJMH2P24iQbuf/9Y9LyQFe2FED6xpxvfHa1ecVGf4y7JC2o5fENTelig?=
 =?us-ascii?Q?KCL2neSkahoOFBQuT7HqPPY0pKFJY7Ta3BWWZOFR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11df72c9-4243-4cca-083f-08db764e2573
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:03:41.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFAhn8+wHb6H1pWYubydoWVGa0yBJ+q2tfSQnMnqwD2zI1hZKK/UZgXni8zdKh06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 26, 2023 at 08:36:32AM +0800, Yang Li wrote:
> ./drivers/infiniband/hw/bnxt_re/main.c: ib_verbs.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5588
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> 
> --change in v2:
> add a more appropriate subject.
> 
>  drivers/infiniband/hw/bnxt_re/main.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
