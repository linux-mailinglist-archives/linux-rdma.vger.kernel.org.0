Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DED4F9BE8
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiDHRoi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiDHRoh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 13:44:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1D26F7
        for <linux-rdma@vger.kernel.org>; Fri,  8 Apr 2022 10:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhYp2O5qxK1uAg7EnwmzS1/YresTrp6bzYEBoTZgYg5c2EJJwSv+I7+dgpiWB8QxqM+Q8jD8ccyiHFZSDv9CxLby40e2WRsXRJmLtYKrZziGdbIv/rAgbGjiLrtUDXXDddaY3SeiuV/J1rVuf5nL5kkM12egBnI9u5HoLZFz4EwOI3hXRI+KPdGiZ9Q0UGiE3I97sNqNj7WzSWdLiImnkOBfkGBN2wUgTfjFzZzL2wVKevfTl/alX6Xswj4epWk3ECHztyUnTw1TGh38u7+EtFZ0UTdrx56qPXyVw5ahWkpBXMgr9Ur39aieiqafYDYW6FziE4bAINiqQ0+5RT01rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uvOEwU858fyYMY8z2dHYdWuxrlHq9SNS5y7u35ATbs=;
 b=AVBxiOayNFB7ZSbHE5dfdbIPZjKUhX078XMCd53z/bmtz3lZO1Grt4TMvopP3dxDWjmeimfUyCBlYO0MljfRpnrC2ajAWMoQcIHwZNt92CkTwl79EYxrGH05XPZrmCuc77g/P2gurCsm+nF1QHWeoP4K7Q/QHBwXTIZX78pMatOIgzms5gK2raGelHfefgcSxnPzi1GUBw2hYjcgmaWq4MTA/t3K+VHuoowDS2B4nkecxamq81KNVt6dO7M5qgyvHeWHZdmLQX+I5/+UjTAKyyQcsLBj9R60k7yHeEENWi8yD5a4SIaNN31dLYPBeRzoBRhURdqRubzj4P0XtOIFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uvOEwU858fyYMY8z2dHYdWuxrlHq9SNS5y7u35ATbs=;
 b=RV9l56oYH73EoIPPwu4hi9owvRJ9VnPhqc8Nggi9cmihgxu4fOM9Jg0FK7PXZ84/jMYoayN4JARoWPR3N5gidikqAMXIEVhAn5bi7KPtuUpzwmNqOBNeagutH5LyQRhpjEdnbqhg5/U+4Xh+yd8vdON+6tfbS5Rr4hMDe2vgZV5H/qmYiZ/FLcSUSsNjpYOnd4caKpJXm1/1X6ihFDU/gz1uUv2S9/0hX8aYOBfKDPQmKBaoyqiqimiaFKyTk0rxPcQ2tnWGjxgtWFLw+WiM8wAw8RQoIt8ZHwbJZAbkKDPbPhnF2NmyJQkeUp/aQIXTbUJheCxldiWhmAhHXGfoWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 17:42:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 17:42:31 +0000
Date:   Fri, 8 Apr 2022 14:42:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Remove type 2A memory window
 capability
Message-ID: <20220408174230.GA3644319@nvidia.com>
References: <20220407184321.14207-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407184321.14207-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:208:a8::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0923aa9a-fea1-4573-c4d8-08da198727f5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1289:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1289EC14BB36BAB9C7509610C2E99@DM5PR12MB1289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoGpclYezY7oM69k+EX2ePevXuVXKY/Oo3n/7NNbRL0WaGUrXLIpSgp4W4z71q4Urjw6N7mPmrrJnLI5Y0v6xOu96OmLHac9PJwNKXGrQxhGihB8Z6aCZ0Oz86lVGXnuwS98S6G0t021X5n8O8YXJGAkyh6hJHeQLlSxdtiKKMyAndKTLzzyOsZouw+rRgZB7Fq7FMqcxHMz0KpIz/Ke7p2ohSi23XF8YAS94n8ux6n7VuKNsMUF7z//WWU+codVBi4FDEQPP/H573l5y9aKE5RjsUnbiE9T07/Ua5C2CFIYxlZ1TCOso9j/3j5CZFi2gRnZ92R7T8TJLiDJiiWIELqXwIuRbLcSfU4OWvkwMcIC9QpO6wvLRlcUlMCk1fMbp0z6k/BelpVpqFYn2Dpw7InFrDCwvPmZZsY5CwoyYgpIxfbqT79XWySkUQ/lcWhfQd6/wEm519PT3fYfsOIfIGf+LoE5dg9vtz0OenAa3Xhz3tTzn/Lk4aiYVdXUQ5pgHSOQIP9AowMUi3t1/DMebX5EUUO6C55Zp2CEISzwVzvIHK064sni6D89s12iKbTsV7dxJwXUGR342RE4fSZezWqi+35ghYUuP+zPpvSymE+OjKPslJ9SNZ2pM6Onun8vBwpfGiVuIngPJ7K90larag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(83380400001)(4744005)(6486002)(508600001)(2906002)(86362001)(5660300002)(316002)(36756003)(66476007)(66556008)(8676002)(2616005)(66946007)(4326008)(6512007)(6916009)(26005)(186003)(6506007)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMr2KOEZsdkRSjiaS/eQSdc8xDEfvEn9vcDQeWhK8RhoU7Zgq0yJuGHe1P1c?=
 =?us-ascii?Q?ObKgUJP/JL9F7700A0NGk6pNo1Il2OnDDJGaGqTfQWj32blSQe9H6gXSDuWe?=
 =?us-ascii?Q?a/kYOyYnlSmzrTmoPAIxOPNC/6r/f9zaqRS7cBsc+gOLVe0EG+Ds0IxnvMnU?=
 =?us-ascii?Q?4nAk4VV9IEHXtIZi1yMsGd24hqTJpLpKSfuMh1iYEfHn0yaggOA74muS4vIq?=
 =?us-ascii?Q?gA5idKS/SCXJvwWlqHStY8UkBcRG7dVRIvjpwLMkcOMAkafOUzo6DYRIfrs3?=
 =?us-ascii?Q?B3nsnh2xHHSJ8F5gw/yZ9PkE0gcqWu+AUazgkP+W7x0VIj+FTvb6fPo/Vzlb?=
 =?us-ascii?Q?SmxROe+VI9xRgMSzZ6977V8kP1qerZBHlblJmG3U+9zGqAGXmltNKetf3v8o?=
 =?us-ascii?Q?Lc4tsIZe2YxHS9pmNJRx4uSiw6Jl7UKV9o2m1zi+3FXEEAn3L34NvGW65EDZ?=
 =?us-ascii?Q?UvRx38Xn7oQnt8ZIrqz5K57ch+LLZudxQ16xDW49tFFROrI0WwothJNAFe7X?=
 =?us-ascii?Q?6mnb0Jh449QinEzgd2idn7+L23GyZJ+UIGrf5NNyLeNIv1Mn8oEhnibffXLG?=
 =?us-ascii?Q?Yhr8tG6Ufk66crRsry8xdX8Px8Sy3CXtS3UIDCeyH6qupixohvuw2zjdKMNM?=
 =?us-ascii?Q?JuMlfxi6ZCuFq/FhZp+IJJf9WdV+aWVd8UkKQUz29GSe+i14nummMH+gwgz4?=
 =?us-ascii?Q?NtcjPMiqRBhovD69vIizdjdAcHVjAnByGa5GvL07Crxr7tnSsfiqKilGNqwC?=
 =?us-ascii?Q?JHhk87qV8zPDflohbEX+2Dmo5AZRSc9ET1TV+etVcHMN4qzmWTL4fblTOaAW?=
 =?us-ascii?Q?DS2SjqtET17OjByrjYNFvmPxj5sjtar5KiXNVhLTGpI4G9ATBS5H/jTHMB/R?=
 =?us-ascii?Q?NPdGvymRKApZBFJ/H9yQbHyk415Bo0QRGOC/7fb7yxj0x7VJwqIc07D3IsGc?=
 =?us-ascii?Q?zbZEknibJvZR6wR5l1qmJNtx3/+7jEVYWOqCK1rGyBo2+qSGISwq/OHewTDg?=
 =?us-ascii?Q?VagfYtHqggK/xsPBgRYXA4NI23h7kRxEx3hr9ynAWR62LINQLqf6dRetMu6n?=
 =?us-ascii?Q?fhkXbGQKnhwfo2rT3w60HRyr3c0vpAkt/7gneKRUwrC87FPLbRhyl0iJN6cV?=
 =?us-ascii?Q?IRKd2AGdtUCFj1PsqsUgu8yx64ndB9q3wMj+K3BPizpaX/RUacDNgsy4GOuc?=
 =?us-ascii?Q?ALOXFX06R9OOEpozLF36+cXrx6+TgeEAaLIaXaQrSp8rJ3fupagc65SdRTsy?=
 =?us-ascii?Q?eA0b4z+VK5LYZimOPbuN4SnMuV4omKgRAdEjn7R02V4G5T/DZJxjApZ5i574?=
 =?us-ascii?Q?A6jIX8Fdp3N2GdGwr+jEP2s7FvcnM+CXMeqVloW+5zlhcUeFzf0O62QS4DJE?=
 =?us-ascii?Q?55KSgXkYVvlragVWYxvHtmVA4WdeUGpE0yKaGO3EJrnbtvtPkkn9e2ea/ESc?=
 =?us-ascii?Q?AmFbQHjcyWQc2aHWFmrHFzvOsKO4eEJ4lUwY9KFi6DpJNlox+LtLYoZ0rFgZ?=
 =?us-ascii?Q?myC0TH7bbdoLCgH3yilWHeqqQoh4EJFDfsO9pR4O022t0xL5RRlHyXpj74mE?=
 =?us-ascii?Q?VK1to0Al8EC+VggGK/nFfs8GdB/PSrdPKRpPYYTV3Xd9siYOPhBBXDPZp6ah?=
 =?us-ascii?Q?Fk9A/H4ntOSohAVEg6qH9YstwTX8z+o1oO5RC6HOMR+F3dr1VAo00loji8sH?=
 =?us-ascii?Q?Zld2VxOwI4wTwGq0xb2DmkLCDyN+NmhTYwtdSnWzXLbYC8cD8C7n4YOAhaNp?=
 =?us-ascii?Q?WDOBW/q1iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0923aa9a-fea1-4573-c4d8-08da198727f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:42:31.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2i6yj7FNo3hMs/jjIvIZjOV3u03MRwaMH9UKVDkvn4aiNcfYabxz09BoLi8n21x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 07, 2022 at 01:43:22PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver claims to support both 2A and 2B type
> memory windows. But the IBA requires
> 
> 	010-37.2.31: If an HCA supports the Base Memory Management
> 	extensions, the HCA shall support either Type 2A or Type 2B
> 	MWs, but not both.
> 
> This commit removes the device capability bit for type 2A memory windows
> and adds a clarifying comment to rxe_mw.c.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 8 ++++++++
>  drivers/infiniband/sw/rxe/rxe_param.h | 1 -
>  2 files changed, 8 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
