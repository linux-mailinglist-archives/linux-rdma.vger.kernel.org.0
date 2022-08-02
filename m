Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D41587D7D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiHBNw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 09:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiHBNwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 09:52:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8D26AEE;
        Tue,  2 Aug 2022 06:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw2t5mDotnuLBkZsW7+S+D/Sh07k3jCvz9UING5DYe+STIN5ZjqGAj2WERGVVwPyZI5pl63v6sFMOAG7vKl6GhRP4g/1k1pzZs1mA2KIOA8j5WZubfQOBvV7zCrR815ennAGh5IJPoJLr6maNyIPtDi8ez3S6JDd4U7vLXbZr+1i97M91Z6l2sSI5WP9BqgDsoa6/Uf1NVA/wkrPYlQHfCOy4dTzAqH1Wbq5OWd4mEDdfhvAfGk7ha2Rhqxdd0J3Ww4mpzaNuEHh5BqDi+rcjLYNPogiKrVaNI0bXxbowCCVgs44zjT5Ich9i3OcNDE7s/rUkSR7pd/uvVoMpTEuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVJJq4JoYCe6O5hd7BtYZjX34jqMLTKeJ0egwP3tVPo=;
 b=UPaS9tcalXsBOf3qSEzh7BKJDv4ezVS1wGjig5nXUUuyrMiGDtHsYUWfLOWSpL44AlNNWSc4pd7Okuw1VGWKhLFSlDqwqhD7L9VBg++JQ6bEhr1l0Klia+pWkNe1eD5E55ipDfvcgLzgB843Z+r1UVWuB3kP/rtYAeCT3xFTUr802LzphkS4Ynn/EoLNtvvlje+EtoLJUgkJgZWgUGlwtmrjUyniMQUzel6oZTyazzMmadiw1yZ1Qte7e089cEFJPvbbUNJLD40ZHObVYPCDoGumEgGJZWKAj52TL+5Ve65gkPW1FYBb0EtutdaK/T0GxFNdv+nKoDoJ6F5ZjDD/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVJJq4JoYCe6O5hd7BtYZjX34jqMLTKeJ0egwP3tVPo=;
 b=OkxsvXh3DKcTUJckIeJE+SiKyVXc5cj/5ixyCbVonzwMotgj6RRjl5FkjtQGDYbelZWed4cCv0qycK/ivYp5wnbVWSjBXrVozbE5qK1hLbRZ9IKAoSmvagegIKJrxEJeRkuYKOQFUky3CsCmHCSo9aDS+SDX0OVg5Ck9S2/QXM5qSr4SlKMpZx9mF3Xz3Oa28LCNkW0UtzZNWIY0E9SNXSrJgUymI0gCIrtNrb78EHGlWjCQUvc6RKV7wkjWHpe3FS5zuVyy6CZbDtF9SXgj+4kZo2lUfSvyv9mxfpp5ay0ua3Uh48Omsy76E3eGANMP+OB0HvcA0JISvAGVVJqayA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 13:52:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 13:52:08 +0000
Date:   Tue, 2 Aug 2022 10:52:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] RDMA/cm: fix cond_no_effect.cocci warnings
Message-ID: <YuksB4Lv9/7Ix5x8@nvidia.com>
References: <20220610094530.28950-1-jiapeng.chong@linux.alibaba.com>
 <e187af34-d0a8-55ed-cc21-d88845ec1eb5@nvidia.com>
 <20220624201733.GA284068@nvidia.com>
 <fdc5931f-5794-1770-0a5d-7470965cf390@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc5931f-5794-1770-0a5d-7470965cf390@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76645cc0-d8b8-4753-ace1-08da748e312d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQz7HbB5zThb5M2OwCb+xQU4DRAz2fNshxehoMmreMRY2oQAGo7AAGAk8Se32z2OrWUOcVB35qaJhOWU08ivPIoO5FugK2xvKNWOlJIh5ObTE5Yd/RPsSQD2igiXKKbNE/D9gvr/c++KO11N4uxRYoZHMH4jZMU0Ezxrua2MS93goHZK1ob5dQqBdoKpZVXpbuD/qLlHqBAcp9l0tgToiYn4YmNBFNhM4H56sufUw5PHLlgvVEeqM9kZSfp4YhpNfGFr0o0FADcv3+KPLRKBUdVg8KxpozVOP6sq7AuI3AzBmXofTdljmhMK1YMTXmybXkByOpaz55VIbtNGLnz1Vsbw+tZxl0hn9glFj9SjigkBo1wT1GLRcgnZFEyhEsBu5a5njCIKltU75Y0Bi46HJH+MsC1y6jD3NmdkqTzLf9WQg/akFh5+gJ1xVden3s9UMki0EUBUy8ZgrHLBQIwJ9XE+1M3q/BD8M0JeyQnohVX1gx2DNNCmhZRFAvJSyCz1IeBm/KusGkb8GvYcoUqFfmkYerAh3MRGpq/dxtlp+canbDdWXvkNksThlRrztHdGgOZ/UHHTQEO7rc92kfeDKwZXzV5hHbL65zatAFhLIRiRhJsJku8wY/xG6VUei3oYkKCttU2Yr3qFyTdpIXd6CPfI9Gtn3uE95xKy/hyxjr21UqC6eZnRT4kQsF+bGUCd00gzzCPTThJa0mIsAgpJ6yMk+zd15hT5hEFN1exfYJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(6506007)(6512007)(26005)(5660300002)(38100700002)(316002)(186003)(36756003)(6486002)(478600001)(86362001)(66946007)(2616005)(4326008)(8676002)(66556008)(66476007)(41300700001)(8936002)(6862004)(2906002)(6636002)(54906003)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+2drj21nbDnz+gWHWQI12EhgnfBZ17x8EfLdkO2yrVJ1DqfSogHzfdVVRNF?=
 =?us-ascii?Q?gSfXIfIJXNcDT/zNvL1zxL8/2Ney+Oc/tD+/Mr5c+8rmubkEJtZ8HFVuqwpp?=
 =?us-ascii?Q?yQZXsGwJiOZj2t454ED7MuG0ue15Airde/I3twUR/yOK2Xe9X8HHoABeKlXc?=
 =?us-ascii?Q?nW2f95qfj73Oer3g51gQFpJ7tRA/7QSx01E1LZqSjw2M9pbGBBIDgnh4rZQ0?=
 =?us-ascii?Q?BcTogEAUSiOg5XMAxsSlUNY/oYnzwJ1LSL3EHtPNpDDbdbh0kh/bNIFAVyI0?=
 =?us-ascii?Q?WKFR6HCtQcfjRjJA+w+g5ndB1HqtzT//KOEViwFJxxk4CaYu4+EOnDWwMP63?=
 =?us-ascii?Q?w4i7YtSBQMxIePXyAYVZJk4vPYHKnA1PvKAo4aBCquhcmbSR0MRVeKEJXfQ9?=
 =?us-ascii?Q?IT0m5DHemul9hHrGtLRJ0a2TK2RNxd4ChmeJ2bzSydxYLhJChTcGesrZawel?=
 =?us-ascii?Q?N3e8no0B/745Ikqb6p2JmoFnGdy/dCzniEanhfpSMu3Lpig/91wuq1kjbidD?=
 =?us-ascii?Q?CfRTu5MPuRUAQwbN5HoKrKSCRabaqZM9BjxXP4erhjuIy40tEJVCl3+nEEVI?=
 =?us-ascii?Q?TbY/TqNJcWX1maDJHVoTbEgyZS1ZMJh3/0pXCC9Wr9FSj1PzF/r+I2wz7uLZ?=
 =?us-ascii?Q?Tbcf1v/L64ipUzPby+zohgFhDoDO28Jevx6+CcFWqgCuGuEtymKhr/jU1+GC?=
 =?us-ascii?Q?aNPuQptMMrC8XE/KPmGt8AEDT2QWVN7fFwIxltw7fjan9QcKJOdUAOymXBg6?=
 =?us-ascii?Q?+XP+9sog8V4eXdChAmJCPcUOo8ItL8fFu7k86nucHNY1sANnAHHRah77XxOq?=
 =?us-ascii?Q?ygwLhA/uxVezXWMp8V8+s8BkSY6YO5tJi1Y8yesyvka7zBvu/0rSNT/F7UYe?=
 =?us-ascii?Q?xcWH/gDNxt14/ePlXzD4ADlWuvLFBhA4UDcUAF1ufXJQ80fUVv4JB6kU/Fwc?=
 =?us-ascii?Q?JCiBJ6BFacnqNLfDs9GeIq6Rdc4RJa6y09LGb+QGN8tmqKqe21d+XF2OkBIg?=
 =?us-ascii?Q?YozTRSj1t2Y3ykDEbYGI3VHhNvxoKU08aC05bQdD/frJ7r/scEF6l32kzxV0?=
 =?us-ascii?Q?QE0vmMTWikDeYJM2Y0Ygc8j/lwZk6RNwBn3LDrPp1gPNYpF9nxAPOYsfgM6r?=
 =?us-ascii?Q?TVvZo5dlwAo4psQVqbedcvZFTVlcADMAneOUJYxBDZmGsv25Bhnx5+rqFjyi?=
 =?us-ascii?Q?SiQwvVDpGd9nlXxWbPj6CIFrVoe2+XhYAOG85LFL1/gLDuQQtdfjx44Ad82q?=
 =?us-ascii?Q?2cwhgwKlnJFIgLKr5V9V6hjLAF9u9AB9m9jC6J/hHgROr/+aqNE+tYj24HDf?=
 =?us-ascii?Q?8WQWp2kCwhyQZGJI6qtw61g1jYBbBqzVwEV8AB89xnUWIWkMbKtkJbwFkTh0?=
 =?us-ascii?Q?LbCAleIl9vJ49/LZ5HHGJRrfhNC/4OjhsXjQzXzg0S38RBHZ9ZTKIOOm1yeg?=
 =?us-ascii?Q?TzXEpzkSLgqwbvFNMIrPjR4hKv9hemKuPebDgt4VT+icnhMBOv5OTz/IxM2X?=
 =?us-ascii?Q?8j0ih9R5gE8zro9XDtZnXDvLSIjAgHZESRqHt+HWR9qozJv0ENCVJ3I0M107?=
 =?us-ascii?Q?n51evOo4/e645WDIjSJ94RaJcLqdzXASsqYZur1K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76645cc0-d8b8-4753-ace1-08da748e312d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 13:52:08.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLoN3uhj/lWYrcVodjX9ln+87JqHzqZLyu3F9uKVGiwqSLwrkN/0vF4TjIv5xG25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 02, 2022 at 10:15:24AM +0800, Mark Zhang wrote:
> 
> > Yes, this is a standard pattern for walking tree with priority, we
> > should not obfuscate it.
> > 
> > The final else means 'equal' and the first if should ideally be placed
> > there
> > 
> > However this function is complicated by the use of the service_mask
> > for equality checking, and it doesn't even work right if the
> > service_mask is not -1.
> > 
> > If someone wants to clean this then please go through and eliminate
> > service_mask completely. From what I can see its value is always -1.
> > Three patches:
> >   - Remove the service_mask parameter from ib_cm_listen(), all callers
> >     use 0
> >   - Remove the service_mask parameter from cm_init_listen(), all
> >     callers use 0. Inspect and remove cm_id_priv->id.service_mask,
> >     it is the constant value  ~cpu_to_be64(0) which is a NOP when &'d
> >   - Move the test at the top of cm_find_listen() into the final else
> > 
> 
> I'll do it. For the 3rd one, do you mean a patch like (similar change in
> cm_insert_listen):

Yes

Jason
