Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037AB5BED68
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITTOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiITTOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 15:14:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BFEA2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 12:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FugjW0W3O+Uc1nRAp3czPRmgduGAvOMKy1Dgig8nv9HnfJGyRPowmBoul+TToZoeT3TRInjWJmEERb4eh8nR96gy7W6lHC0exzoczIv216SxomfN0M1//W1hUMKAcKYe/wkaSQpEWp6Jex9u5QmrkwvPPrYTHk50ZKeNxK1leYxjF8HFI3x2cpNmpuUk14SJOfhEZL/ATSPAbbUIvOoJ+zDjfOeB5BdcT7xe6PUT24j0ZPr2yK+Dv29aSFkLM/osuDFUYAHYKMsi+lQaH11fFadhfn4Upst5OjrUTNjTLcV3rglHEkeoTDj3+S4US7CQINpkyY3vWjR4+iRpuKn6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZILPfF0bZaiXwEYO9v0KWX9dK4V60c7ChMceX0LCCJI=;
 b=gICQ7XNLyUfG0yJQyneeuBoUHJbHagLUrgicdZbBJwSr4BQwQr9qdx0bMEPhHmZBOVq2CxvpjUWzNiOpgcqRPhven3WiGENrB0gvooNF4t4B6+gU1KPCYZrMQD5k45DdEmNGG39CHnLNSJeNI3rGCaSHbPQZjaipj7cnYDc2CvwNzGkMO8nUf8UtTZjrqJw4KWgA0JDLvJq1vRHCpbvVm94FN96cWpP1MZlbGhqIoP+YIreA2gVX0L5K2k4TUflPCFLqJGQtWoqVcupEcMsf1OBdNpfaSJY6lE3B8hFP6LUIKKjUYCbJYLBTBSVQOD53pyZy65ymtNAhuB+gWsQm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZILPfF0bZaiXwEYO9v0KWX9dK4V60c7ChMceX0LCCJI=;
 b=DBZk1ADC/9jPPHNMl+YmPILDN8s53ZoRNWUcIQVl/l9LTyqdE9q1NA/PDzMZuNfVOC9b8ibhG/1jkLBaIiYwc6E7bZXKIMMsWyAGe1p7aQR+yrt+/C1iMUc5EmNqFJRhP+0LXrstgqm26bL6hiQx/Fa/Q9C3QvSKTGIM7gwlr1nYCpTluBj61teNGFsFRRWEwRaZ1Rsn6qT6KD/GqtZg/j4CKiYOo49xLu15xFT/0Esxj5AE1hOYL/M7nJiiV+sCz91F9LxC71cNf1JWHrdM8egJLzjY/NUdmtRvs6aWHKGTFkxW7ctyOovjotkqQ2KUuDZhVo6Kvsn9uaFA3pfrsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 19:14:36 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 19:14:36 +0000
Date:   Tue, 20 Sep 2022 16:14:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
 boundary condition
Message-ID: <YyoRGzNiPLwVZYjf@nvidia.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com>
 <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com>
 <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
 <YwjHSBr3f4o0hXBX@nvidia.com>
 <85a37f42a08f4163cb5440d8825b7e7a@mail.gmail.com>
 <YxeEX7XcwYpnbP3M@nvidia.com>
 <fc18b231b93a47b8ca1314f3778bfe1a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc18b231b93a47b8ca1314f3778bfe1a@mail.gmail.com>
X-ClientProxiedBy: BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 47628e0c-ddd2-4268-5ad4-08da9b3c5b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgDxCtFvWDqM1lOWtuX6uqwXTUd3OyrEeXYWP1gNeIMKI8vDeXyfha365P/4y/QayiTIusdC2JWf3wNv8Rw10WEdKDl/OJd7uUU0Seo1W4i9ZTIKis5o53ZSBKYrG3y7cj2djtjsKif5ZCOz4woLXikQthzIjdJoPNAMCaOYShlJDGzV1q0rwgqyF/GyWflEu+4AkUfeIf3jJX6s2Q4lF29DmOownN6iROqlcltIZZKMrV6emDMVCzNIX5G6s8xnfG3AbrxLEuHE4RGJOBxZ5smlwGjP0aZl+402uAd2D7+N52m9tJ/KOWVhNqiSOajSEYnNeZZDpL59F0fheuFldn5MyMmvx65BPj9seJ7dGZdcq0rNn7KxKld5jz9PbF9hXu96XBRfW/hW2iyBgO37ejTxZqoyEExJpPzbSBwDtmzKIdaZc/+wts/ihkFseU2bx+1aG0bDzIT/O5TKLTEkSK1zPRDEwBwabYKeqFH/uIl9f/iNTjYH9Z+1H13LLPtcuie1XebikEz5Gj2J8HnBPetsZu33g9+tc/sHfaNNUHT+YL9jb1Ote8ZM7RFbdsGypFf+UKKB9ZxlYpm/nQSxv2ItchBYJFeRwHL57Hw7e7khHZ+ixE8UiFG9vvhcmUBj1BfVu+/RwyPxYBkgpCyMlZcb5nhWFIixZ4jtq43SOs111Lkly6FnBHgfj3zRWN+RpV3OI2jWlUeS/CncE2WzGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199015)(38100700002)(186003)(8936002)(2616005)(6512007)(2906002)(54906003)(26005)(6486002)(478600001)(6916009)(316002)(36756003)(66946007)(66476007)(66556008)(4326008)(6506007)(8676002)(41300700001)(86362001)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BkQSp3jvp6S2WhcoccRF2vUFCI6K6lX3rGAd6tOMFsXjU9QB0Cf1m3phW49z?=
 =?us-ascii?Q?vMc87zn1yBtC/Ct4kEuT0J8XLfGd7WnXBHvvhHki43rAUWMrIj4Y1jSWQBv9?=
 =?us-ascii?Q?hwQxUM4bwuyjphslTMLunnbbgitAoK6gnAgpHItrw9NdStChXoHuZBPydtV+?=
 =?us-ascii?Q?X/DrR9w+HDsQE9D3GIM2nBklGXTkh8+ubgZqds50YlHEHG68DfBysHQeaQwo?=
 =?us-ascii?Q?QIvRsYxJRZL2z5Dm4Afdr5uVL22Gvkj65eEMM5CXBQyMiPkRI4nsxdvAg0wj?=
 =?us-ascii?Q?08Hzp8Q/hauRt52AGMRKG0tXugNZlL2tuD0+RkGe5DFtb1+e7N/MBP7Ugw8y?=
 =?us-ascii?Q?q8+2l+r8pHwGc9tPWrIj7adEg3vm1ifcYzbk5nOdYyBudH3Tl52Ezl/eJi4u?=
 =?us-ascii?Q?fE5fPtcHbhnOppYTOeE5zU6dyuNcplShA5xBfmG7mfi1A2NjHuo4LW/dlref?=
 =?us-ascii?Q?ovTanqYCot1m8pHt18UfMUcnRtSiP8TO4IJYNNPB1f9yqTJva/iCl6D6qwbf?=
 =?us-ascii?Q?NuhvciXQc6+sKAXe10YLhtaNC/grX8wFyZLqQZ1yVoRjUMVFm9TDqbtJPuE4?=
 =?us-ascii?Q?7zcovpRc3v64A5J3bsapbsjWz9f1RW1ZDfmAxQYHb05OY/rHeJG8UQaF2Khm?=
 =?us-ascii?Q?d++xngYOT+/t9nxQQZwUTWr/KQ/0iPViT+Tyde+plBEARxLpeMKIXoLBrreb?=
 =?us-ascii?Q?f7SUD+jw9+IZsV8A1mW60OuVO36+lUo/mX3o90uYfchm89lSgdVNU2UjFgox?=
 =?us-ascii?Q?Sbf0ZwjbVMx4lAbYbWlXAGbJddws+6gw3tQ+LEGwR+44tw0gcHw1stuTYLX6?=
 =?us-ascii?Q?psnmaUekcwE0ekGQXbqMXw7sxpOXurJ9MZjB/NmGUhIVQsGNgW9M4X2Gq/e9?=
 =?us-ascii?Q?leE2qDhh9KDBPr6PExWth3DYkVb0YdYYHz92+NxKxNQM91Wsvecn/N4InSsA?=
 =?us-ascii?Q?/KmCalSAUxd+z6ewTF+vNIZarPGfkrhnu1RgL6ymH3axIyL69+LkZNqWCgKu?=
 =?us-ascii?Q?6EDF7A2/OSMQ9ct11h8WfP1YBCyylnbFizRi72g+yfxX3Ta4DFIZMLd9CuTZ?=
 =?us-ascii?Q?JKrT9YCVQ9kLrMut+QU/nhjDZpNjC9caydqkeUk0Ox/aICgFQOGPzAjpOVc7?=
 =?us-ascii?Q?k5scUrEEPDHcTVj/CRSfh3FJEkbgauLh9B/jNOphha/qAdQh6vA6b2uQ5aa1?=
 =?us-ascii?Q?eA1UDWNpgtpUdVGrLxzTAX+1lKII7wH4N7UWuVnBMu/FKOVGCGxIvnyuvksb?=
 =?us-ascii?Q?iX4HzFmojBWZhdIsCdldV/LzP/BA4AmHoCWhDxspNWkcj8RzeOpv7lekYpmi?=
 =?us-ascii?Q?ooWM6E1KI/WhIDoIXNIWu1DdKYfXjkAaGPBDTSn6fTKRrykdZ/2OYk27A1AI?=
 =?us-ascii?Q?peEMNhP0nCR+jH8C9r/cU7TfuTDp/D9v8f86k0Tp8Sj0GCTQfVAbaouisr0f?=
 =?us-ascii?Q?wbmC7iilz9OBdAmRWcqP9T2qtrDMUQCtQazk7MuAgD1gM5QghOVyxhe47QeH?=
 =?us-ascii?Q?ZcjUJ5pQR4rnOSEvhst68vX908AfhL5eaflQthZZSsTayFrdzZyzCVrypBfI?=
 =?us-ascii?Q?/g1AGJD0Pd9cHe9EHaZleDfdvUSq+owoU8CsKqMG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47628e0c-ddd2-4268-5ad4-08da9b3c5b67
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:14:36.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxWZPVVaHYjbAEUP4zUkZXGaCE5bpRBj8ICHDCE/6HgtvZeVA4cS3oBp6mwoSMJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 12, 2022 at 04:32:09PM +0530, Kashyap Desai wrote:

> I noted your response.  Issue is possible to any RDMA h/w and issue is not
> completely Rejected. It is just that you need another way to fix it
> (preferred to handle it in iommu)
> We can reopen discussion if we see another instance from other vendors.
> Quick workaround is - use  63 bit DMA mask in rdma low level driver if
> someone really wants to work around this issue until something more robust
> fix committed in upstream kernel (either ib stack or iommu stack).

That is not quite right, I said it should also be fixed in RDMA, just
none of the patches you are proposing fix it correctly. You must avoid
the mathematical overflow by reworking the logic.

Jason
