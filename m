Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5569062822B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiKNORR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 09:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNORQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 09:17:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19812252B5
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 06:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCNuZq0HLYcEtSt2zlZgcUM2JSlJdvZmMIexTG6ln0QaY6G8a9cMBvtgLEkPk7cmtBtL9QlocOovUaZ40b/Qpn3YoV8qSmG/p7oBD1mgaX/gaFMh/eofyjkrxE9jJ0jABn2umdsefey8fkEU/dkB7ljl+b78YccYPkJpsQFpcbMTE50ZQQgHHVGauFRXs30wdpOkX7oyR68CLadt9R4aA7n770w1P7uj6XuTqvh82aBMNgCg3QNRdo6TEX3nq1mNhdTM52HI1vLbFRw3ZMKRV925yFssTQdZ71AcItVkrHrw81zoaV6qqD9rJQBUkO1j3x2n/SJ3drsKhU3s2tjOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXXGXydhpYPZ9zyyAuPwMyLSZZVpIfR3TcTdBmLTbiA=;
 b=fOMqENFrvIEDkTNDKOCk0o01eLFK/5/PppuwNhcr4csbiwYGGhMzn4TY10YNzcXAX4vLBSPWmRvBX0c4SQgqxCCO0VjBWIC4+9GjZxoFr13s71tvwzzO6tkVR6MXmqgYfstyDhBUaqyGfu/VM+lHmqyPV7saOemnY4b7hxorOClwb4g7CwHlSZXcu3XRd+3zM6Oge2CTQFKQKk0WoN0Tc8zjPxdtM6LvRz7niUUaUA6eMYyBzLOTZEi6Tf45aFtp9S5u5onZ2pcMPcBL4ANX9dh1b1t5FFR0hobThGKqiJQXMFawLkLiLautFWycd1/7eP1zOu/DFQ4885CaBLlhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXXGXydhpYPZ9zyyAuPwMyLSZZVpIfR3TcTdBmLTbiA=;
 b=C2XOqcSAnwFaOk/UHl+/thhUnOQA3uwXRzilA+Fv8cZ3HKlGD3XP/eYrXoJ6MwV1tM2B2GMa5vwdluxtjjiiUn/Ed0DdaSU+h2RQF5RFJgJfUExffPAWmwIFDq1weFbkG3WNN0HVvWbYbHJoPwZOoH7VvXpHJ3hwmeKc6lq/6lZYD8RW8huuLdLpUFOcfXeOUeaqg/JVtsRPAmloggg67kd4pNDlAtVj5pjp0UIxMPTqvLoKiJfKL59vEeaDhRsxGFP45/chtrAvYiqV4FmDm7FBFbXwQZ2UkLQP8mlLfx76cBHhzN5iTaAod9h3wV8tPsv11a9sWFTBV+/jtczCxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:17:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 14:17:13 +0000
Date:   Mon, 14 Nov 2022 10:17:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/nldev: Use __nlmsg_put instead
 nlmsg_put
Message-ID: <Y3JN6GVUgcjbHVv0@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
 <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
 <Y2v8UsT015iiRuob@nvidia.com>
 <Y3Cany776/OrEpbY@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Cany776/OrEpbY@unreal>
X-ClientProxiedBy: BLAPR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:208:32f::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: dd479344-7890-4b1e-02f3-08dac64aed43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePsRVIrgbvc7JWO32Khhw7nA+demwLTJ82XLnbmzZ+9fPb9PGhHXOag7Bs9z8UISbDwf9Rh/N7WKgfroFMlsErr08Cd6g1xVcP5Perv3a1TCPKv2susNkj95JDcLsv+Y7T3WcduWtehU/O3BTfbyIg5nH74MYUY7ASNaEg5HvkN5p/3Rps8Tj14kSeCSIAP7OHWtdUvihoFAW1RO6964todkA1WvqqpZArAf3kcOboVUlZ8kjzU/hA1UQONfS1oc01rL25zi9sGG9MoL0afKdvVuNtEIbpp9epXe1hBpwcYA/LkbnJ6Hlr7EXug8/RWNQ3w74SWJkst+uJK98RVB2oPVGT80P+fSLu5m1kbXVc6xfkayTzTp/7hQTECTVzGpCpLD15pfWDgHyjfXneojgvvX9UzlJMiEzrjCEf8myCxlqLttM18yE9dhAJQgDIQ6G2A562Vw6wPSXyu7Sj5z9tyb87qVpMed2M39rcjKYEreeScYFnOeGdDPen1YeIRtpcH5bS99UySq8u9qpo8OU6JMSRRSBwdt/MkPb8D4FRky5nlDFlsxzJ60WNVQmhsHj8YGqfdZKxfo89QSgwRpHWX0mxmeH++1pr8Ll4pTXrvwg5EhkOqLIMGEZM3EGT9dcUJ6+Dr7Zu9lHLnpERYHq/4AORJh0JJ7+Jr0EVS7JeoAVRh9VtRkf15NTm/C+T36SLTbOPnUp9xiHnOI0+/G4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199015)(107886003)(6486002)(54906003)(6506007)(6916009)(478600001)(6512007)(8936002)(36756003)(66946007)(4744005)(66556008)(66476007)(4326008)(8676002)(2616005)(41300700001)(26005)(5660300002)(186003)(83380400001)(2906002)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWytQwSch81rO5JhL1WPyGZ0Epq/MniYXY4DGAjHRkVPPWoo6ZEp/qb9UOzt?=
 =?us-ascii?Q?OJDFe7p3mG/x8KmSDxxfubh1WYDnEXLUFfoNb2tkeWrWSX+aNeoi81sQdNrr?=
 =?us-ascii?Q?qDIHwXyB6w/BQ/PZsX3wu6Ss08vQh84w5zmMDpiLppHCYKj/KimNEqawdAQk?=
 =?us-ascii?Q?UV/ERK6v1QFzaLWMOSJy7TfHgNljrHpaYoNlD3+izxwqq1J0ySdnOMVg5fR6?=
 =?us-ascii?Q?ANy/xun5dgTUAOrG7bg6NECTjGOs865SaIHZPD26SAx2o0uZqiMG9W1xul4d?=
 =?us-ascii?Q?yqcRvlW2gWB0lwWntSE3gN+4l884tvRJ6L4Idv045KsPgyHRv8suwzTqVdYR?=
 =?us-ascii?Q?xXQ6bMmiphG0pPAUe/slDsy7tQxtd1eD9MDbGuyM7i+4V+1iGWcLrtxcRwFa?=
 =?us-ascii?Q?YmydIitOaGYAey18RU4bBf1DPxgBya5gTExGRH2xJxda0vavL3G8mGeWzo+n?=
 =?us-ascii?Q?bjNJVSf8LDy4YJUFkZA2V0VBL384KpW0jhUxt8/6OC1r+ZjUuqyfI/iEqV9g?=
 =?us-ascii?Q?QIOZWFoUmeQ14NscJGw5RJFUVz6ZMnr8DcGZOKCeGZqaOCupEMMTLSxTXqww?=
 =?us-ascii?Q?b1RED6MDnE/5Uvv9RPHFZjqA1jslRR/iwHm9YgRo7qHsl4Nj4SsXFX919e9k?=
 =?us-ascii?Q?VejoQoTtOYEZFX6bWcTcZrh7eL4HSLbckRZGcEw22XqI7wos+PB25R5UmJfn?=
 =?us-ascii?Q?FNQI9wpax/jgDxLF5tKjrdBGxULxJTVTJxNLjlS5X3wYqVWayM3Gcb253vkc?=
 =?us-ascii?Q?3Xz1mAU1fN5CsfIHC5yS7rQzd73m0Vq/3BUGAGnS4tD/Wetq5P10RhgiIbN+?=
 =?us-ascii?Q?lWWeieA1DDCbfSMQV/geLS/MaJEuEAs4iCJROAp1DOxLNpUpHzSrplFc+tFi?=
 =?us-ascii?Q?eMMkiocwLWj/OKKZdg7+4A2NRZqerMwvUrw4+oVqIHaXFHomUM2pas0BqcND?=
 =?us-ascii?Q?VjQrfNg9Fju1bwWIZ937dBHkN1jmcc1iB5hV3LFH/xlbKe50FQ2VnDEDlwW0?=
 =?us-ascii?Q?R4LJeKWNbxBsKnA91lMWyGeqMKRUDoUx92cAJXzQwSCuF5pG4gVkS7H/18v6?=
 =?us-ascii?Q?n4HwzG5RP7zdr+UoPW/QdIh5Ooxi3nvuEa8z0+o6ejRHdupbGkxahO3jZFCW?=
 =?us-ascii?Q?8AV/acTFVLNRaeOB6sxGh+GUfE5cb48Orh0+5GboxNgRTb6DAY0GNPZCKnDG?=
 =?us-ascii?Q?nip6n2lewVNTzXhd/DeAd2T64yZ0jUBDVl/PAX7G2ozyvsWdOoYuFyFgcOAJ?=
 =?us-ascii?Q?4thBLbtS4UW2sVvPEnmY7i/pBrxgIeWHOVgRCOU8SqcVTUj4Xw2dsYV2UvkS?=
 =?us-ascii?Q?cimXKQITt2KDblHPJCBIWNERfQccaZAns6I1AvyZSgyzHm49N3/6FOxZHaXy?=
 =?us-ascii?Q?nWsfRdFmCIvvs5mNJjuc+RU7vBYd1QQAy1o1Kts7ydHh7WXSQvygxCYnZat2?=
 =?us-ascii?Q?KZlgcv04TJjBniWy6rjjA2IwziFelEHnvz4r4kungJnsbOfoR0M+VLuiBNFA?=
 =?us-ascii?Q?lKqcWUpmZUHU2RSlLWNuR/xS5OV9T6Lxq0JRBVvhW5E1GY9VJnogHQ2/QcGc?=
 =?us-ascii?Q?lKt1zLDryZsOeAP9CtA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd479344-7890-4b1e-02f3-08dac64aed43
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:17:13.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTzn26rQ3V+0BDuExgckBd2aGIQ1SXg/XvO8IoYfe9KOhV09WQb2hNVC12aWfF9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 13, 2022 at 09:19:59AM +0200, Leon Romanovsky wrote:
> On Wed, Nov 09, 2022 at 03:15:30PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 07, 2022 at 10:51:33AM +0200, Leon Romanovsky wrote:
> > > From: Or Har-Toov <ohartoov@nvidia.com>
> > > 
> > > Using nlmsg_put causes static analysis tools to many
> > > false positives of not checking the return value of nlmsg_put.
> > > 
> > > In all uses in nldev.c, payload parameter is 0 so NULL will never
> > > be returned. So let's use __nlmsg_put function to silence the
> > > warnings.
> > 
> > I'd rather just add useless checks for the errors than call a private
> > function like this. Or add some nlmsg_put_no_payload() that can't fail
> 
> This is exactly what __nlmsg_put() means. Function that can't fail.

Er no, it is some internal function. A function that can't fail
wouldn't accept the payload argument at all.

Jason
