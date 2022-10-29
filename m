Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF43661245C
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ2QHu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2QHt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 12:07:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DA3336F
        for <linux-rdma@vger.kernel.org>; Sat, 29 Oct 2022 09:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2zocNtPaWSbVnhLpeh7exPdN4bCBdTSKc3YVdktu82B+kUsDaRHmWVxWDfx/SsISQR2AKS4lIawT7D5PC8TscZMOTV16hqYt2mZFs2PIBeZ62aQXCMMiiB+Zym+hjBMaxAkSkHxeZPt4AyB3mfR1Xp9/VfDSofveVipYSmUxBPJIe4ljWtsth8dh1cdgzyzE0tVoqR1zmab+DUm8hs9OQF3jlYSVHRaIOYpCnqFF7sgPnD0Snyy0SSfMmjFmY5dajN6x/gU9m3FMaoIcQZiejLELyKvexca51BGXe0UsPsDcIIWRbmya2BgYqPUsPnFMN9WKfw9PWpb3khpbSUbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJCQjGB9WTQXZaqwjGO4GvV2eYxcNGveBWydtdZ1CfE=;
 b=BPkakzVI719IXpO24KCQn8IsCQFVT2VqP8S637l47n1ErK+X9qx0pSPDD4GRfDLjdrhHx8KWA4SevGs6qJF9c40FI/HI9H86cgNAc8fiXlWV2d3evS2pNyqogPuzCb5VKpTViGHzfpIWu5jrTLy0wdyr7gXcpSpPgnfPBBkpgAKoQOen86TCtiutlzR1ytA3QupA+lRJANFcl+KDomNttRi5pmgeqNmWinLg/W8nveg8F5sHx3wSUBEHTVc5uSB3vFMTz2hbc+LQc1904AARfZxK7NUNDFYr8lBHzUoMQ1ncnFrz0TvDFTKoccqMYgW49fKoJ2bFalJa7WhAZamGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJCQjGB9WTQXZaqwjGO4GvV2eYxcNGveBWydtdZ1CfE=;
 b=Yfgw7L9ThhMGaWLDobu4G8a+wnNSqyWwJquTt2wuay+xAP+M1ur5fqlvRyxzUhTGgCDiKD9Gf4Ilr3LLKGuC//SPmpjZ1vh26p+cyG6YQkP1Npqu4/MsG4bgSEIXNOKcOpdw9HCZCLdU9dNyUAsF38kfZ2zwXAVuQBmKh5motRofME7QLt56MuW3KRz0y07VNo+evJoh3eedtOFX62DPPN65ROe9lr7qwvG2ZJk6C+fBqZ7AApXGquLycwdqkKgQ9IhnN6jGJ+M01FWDoGUlNaqmn8nYKCxJXQq88o8dBNuXzbXA/slJR9xUQVmXYjaSSPcw//66cB4HRQzZ6L7PFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Sat, 29 Oct
 2022 16:07:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Sat, 29 Oct 2022
 16:07:40 +0000
Date:   Sat, 29 Oct 2022 13:07:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: I resent 05/13 because it was missing the for-next
Message-ID: <Y11Py4dE9my3i3Ys@nvidia.com>
References: <8cca8a95-f269-a85a-9104-6a259aec52f7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cca8a95-f269-a85a-9104-6a259aec52f7@gmail.com>
X-ClientProxiedBy: MN2PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:c0::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: edfd4a71-c986-4148-e905-08dab9c7b433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWAmk524eKcq2ZoY2etPvNzuy5uF/C+pKAM2NQvvzCtAeupLqG1eZpCLabMzioEL5I6Y2HUpnTLGORApX4HN7ci141U7BYXHGe7i+IuLz1U0HS55ez1lrtPBg1MUGIphdbZ56g4qO3jmIKW55AUSQWubW0eiDLAjrT5m+c2aZX7T9lAnHCV3yTTqDHnfVpp+P3nIpXacSsh+IlUy2etIuhh6NIDARfC8HgfKXgtDTsWvwLpvOKUEJhiHEWu9bHCzn54SH8iDDm449CEHXH4HU2Z6kXTl1AdgFzajWiodGPsqM5padxVgQ4XNEhlwuGPqrUDE0Zd03aAEthvJk/RpwI5LanR2Sj2NrJjpW9X18ttvMcLlyZVBjRO51AbZOzu7ILWYIW6jMky0kzkqutvbc/iHz/3x1kIKJwulVYWYcAJgMq0LjBFyoHLBbfhugS0/S+T+jLeg/CVGvRU0nDOE1D4BwChilJ6JDQzXRdYf52PCnF4P//IBKsGB58sTpCYH+PY3bBpM7TExsXNxTJNg6d+KR09b5vN0bbgzf0rQTi+BGJ2zGGjqlGQAfDOMyOv775RdZT/Ohm8JhqXslXnMKehJ6bSsLQW3weegsJi+Vt1qOF+ESel6aGj26o4kBc2I8VK3VFQ6rIr5Vj/nsFtX8TQ3WX9AXa5U7CXpGNNwCguFrByYi9zIecP2fDnybGAZwqHjxVZ59Unv7FdxfbnK1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(186003)(5660300002)(36756003)(8936002)(6512007)(41300700001)(26005)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(6506007)(86362001)(38100700002)(558084003)(6486002)(316002)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4EOuru9QQxcn432DCbBiSHVOj8ztcn8gAas82WsuhjnzqQD7EmkPTRf+6S4U?=
 =?us-ascii?Q?VOgXEiNlMw9G/vF9S5cOUOt+7NOquGr/voxPmX7cUYNPvIcvY9nCkxIM30zx?=
 =?us-ascii?Q?0TSOzOrnFntH2euEbep2cFWiWFjvAan2uvGpgEg7MDLnS01FJhJNcUs4VNpY?=
 =?us-ascii?Q?yK01lE+CQoIsk2LFV+vbtkr8lNyKOSy0yqkbHfpfXY9qNVgV028Lnei9GP5x?=
 =?us-ascii?Q?GgkXPMrscFDI52FRoRlwPjnV7m26GpZBttVyB1ijcYz9gpKuvTDIdZ/HaTou?=
 =?us-ascii?Q?ZQ7tbOkWGK233ZIw91ICB9GbcV0SK25+Gkj/9+gXahBPmcmBiEn/J5Vt5ibV?=
 =?us-ascii?Q?pNwyCxGSHG64X1MPSM2joCxa4D6Pdm6n5OfZHLZ4Ko18yOrNmAQ2yKwt96nB?=
 =?us-ascii?Q?CE9zRwTpz9lOezMTpwPCVTnLSbTkP1DA7hr4rvLjmmtXtpXbgNUpFVCxs4ri?=
 =?us-ascii?Q?vCERgq7WPZbeaV6mjA8KJmGiHnuM+fnlooOoxyG1Gyeca0rV03fgW7wP3Lo/?=
 =?us-ascii?Q?vl7HDjYDw8s34IoWKpExHIqlTOKDWiwYfNBmSOG52EnibntzCPWGYVTx8tGs?=
 =?us-ascii?Q?2o6QUedhDZpJ7B/TkZ89/gEikDxQ0NMkrEM36HU6NWNi8cDkbUJYX/bpfxOa?=
 =?us-ascii?Q?sCjfoJwpw01JRcfqErwqmj2lhB/IKrSqRtolWoOofaA7Gd2TzRemBkynEl0J?=
 =?us-ascii?Q?8Q6iK2JKijcE0h8IUbNQHgHjzfcuxkv6TGoyp/6EfgX5GEAu71eiRnSSSshw?=
 =?us-ascii?Q?MsaZGKGrdvWYYlONdkO37ji3o+OW+BYuxazxGErDzg/dNq3rCk3fSa99AVVz?=
 =?us-ascii?Q?vJFHsHF1cjnoG7/5hyj1ZnJzkq/1lIA67NE3uf7ufNd9eeUjIDjNHMeYpfJo?=
 =?us-ascii?Q?J9/owscvH7Cwml4R/TyME6fGFK0JCLLxW3/9tnoy8jQR+bYE6SPHj/rUg6cP?=
 =?us-ascii?Q?dJtqsHDXj5Kcarsw5NYUgg6z+2eFb5xVA0vd0khJSQIsAQhKIloKwVRDCAve?=
 =?us-ascii?Q?lRwRq4xbAqThod0EKLtuPM3LaUqRX5poc5E9ynhoQAPkUbpADkUusOEZyd89?=
 =?us-ascii?Q?nacuCYSYsox0VhSU/kDUtP2cYlj3JODeRQn2nQ0/y6p3cAlSSgPft2f87wq5?=
 =?us-ascii?Q?JtI30jdBJ98aA0CpeUYex0bMsEBysX9I9YqIH+zE0DjNYd4X6w7QGjXggiwC?=
 =?us-ascii?Q?Rn3MgWiN3qUW06J2iHKeQ+HSklSs9CXof7R+a0L7D6tqwOQHNw3Ys6Lm2VUw?=
 =?us-ascii?Q?43URkMdSjuWDmedJelTxk2B9GZvE/q/Gfj3dvVIHhjQif6onwKGp2Qmmvq+c?=
 =?us-ascii?Q?bPYnIZ830WK7wPn+5u08d/tswb+1F9fFUlwgXzSosRqzeq0Qyuzk6seVLiZr?=
 =?us-ascii?Q?MIT5STfIaKSGI9A0AfcUAeSXPk7COhcLVrDEpI52lk5/Rg4MsUC+mANAzKSJ?=
 =?us-ascii?Q?u/LQs1OP0COSa/nd4YNlZaphQBSdwGLJTqo6woS6u0d7EAjc0t+7bOtRgKn/?=
 =?us-ascii?Q?kIjtv/v7+YIIWSjJEctICAeBU8xtu2yVV2IhgdHCJvuCwctREb1OFWhJPX67?=
 =?us-ascii?Q?GfQIefxENVDyXzGYX6c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd4a71-c986-4148-e905-08dab9c7b433
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 16:07:40.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTpgk2yzM1DCU3j0yFbKneP/Byrvr6/3UXunYIOjVVndSqwPObEX3BS8HzNVM8G3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 10:14:55PM -0500, Bob Pearson wrote:
> I had put them in by hand and missed one.

Every time you do that it messes up patchworks

You need to find a flow that doesn't have these manual fixups in it

Jason
