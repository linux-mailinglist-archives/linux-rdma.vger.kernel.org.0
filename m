Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FA8528C02
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbiEPRbV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbiEPRbI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 13:31:08 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E14DFD0
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 10:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1GucqywDAyPIfEy3WFOfuLLxinyIHCJVarRpNOiTLqvN3+upGViVNOT4/2BgYXI1x2O0iNS7dRgZXrqaKaWQT9Z29m5abeprvN9yjGznhjInsXIKlE9a/aGpH3yecpNEQo1rXjDwbgZVH8DPzFZELP4+JW8yIuy9JlAO6NwISPmEXnl6LUYp7f250jIP/YJy4PPMbmPRRLAkHpLO34t0qYy6zZwd9Mm5xXe68+yRiKaq5cTVS2WD1uz7ZoK0ljhuq2VjJEGUkXkjf/FkCpxEI26q1QPFuaqZZPbOYXmMsgnxscgRDLlTIZnDep9EUzy3McGHhUS+3dWCGoMIvEJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/d6qNR8RdmxmyDjO76cPWxy81QcQijtHFvxuczrcN4=;
 b=i6sKddpn3YAMUrPXhWmNy95tG6JZJIe1KIJCDxJeGdC5qUzAAxKroKXGzlRImFXq0C1RT7QIbxd5UAZIbXNFdBIA+p7e8XYoZoYlIrANog/J1YtOsCLgWwaD+1TMnJDkVXVpsFVwGsN/ZAzsmd9znAw81M+afpk2eqB/g4UlnstYWVyuNWB/O49WhdKXQCQJUFwpon4MTgJsYNOW5spRtTYXZgK/IeschEotxx4jnl2MoWn4QCD4D70qNWXstedy9ckBvpDxIhEQ6DWZSuTMXHTBig4WGxE3+M3Kpan5XOauIIgk302rSb5N2HDsBOw02NZ8yyEuGBkNkelyVctC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/d6qNR8RdmxmyDjO76cPWxy81QcQijtHFvxuczrcN4=;
 b=HShrbT8Z1GMQs8/Gg9kiQLxQiFCuvCLeXIOxsdBEvNFcWXyZucXCRCoBFERAfiV3MLAkBF+hdbmgW3SXaZ5Y/CndQN3QTWXbcwv7kiYusU1/tE1GQI03HUC2QHJROaOiN62CdW5hdgJ2uOPWFzKjIVbVBWEIIALmnRXxZlwZ24rMJaSPCtHZMY0/VTTfyhVCC5KVQbjzf76qhqiusWtvnSoOLjLywNYh6BAPm1Fp7eZ7O4a4si3qeBdZJeqMM2LBVH+DB3SguVzuWVQJCQNQsl2lHsBX8beZz0F+0sAZbT/QfQfOba8GUXIDK+r8wrMZfq0bVX9uLXHGCngi7uCVAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 17:31:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 17:31:03 +0000
Date:   Mon, 16 May 2022 14:31:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Message-ID: <20220516173102.GF1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <15a6e72f-2967-5c19-3742-d854409275ce@linux.alibaba.com>
 <20220516114940.GT1343366@nvidia.com>
 <3bf3f0f4-1592-2aa6-42c7-f1b4ff73fc6d@linux.alibaba.com>
 <1b6dbe3a-8b15-3c56-5353-27525095962a@linux.alibaba.com>
 <20220516140721.GW1343366@nvidia.com>
 <eb2f87be-7d9a-72c9-645e-0d789b604c2e@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb2f87be-7d9a-72c9-645e-0d789b604c2e@linux.alibaba.com>
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e8ada7-6a3b-4551-5b1c-08da3761d9fd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284E3973FD403BFEB7B6E30C2CF9@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2nfS/HbolYFr9TxACDDUyfMOQKtAPp4OVoffsl5WxK4UPogqp/BPleikpfS0dH4teE/boSxivNlIbon+DXO8VB5hfeNawAo6Xwfc3cKb8nv0skRB65iYZEjov2lFLssf0m5M21fD5MFxX/5CO3FtOyuyD7PfNVRu25ob9tX9ztCUIhxGhqxy17cYVB+ASYJDXitvsOZc9weNCHOV0/F3NMGffXR+WNv1BMirL4+NLU/Y/8v8G4EoU6ixPVDlDueSgCm+Xbspx4paz7b6hi9zC2MSDZEYotasKFYa1/fUEeGxWUTB1iKIjYXbb2bjSikiAmJqthF3gR2Bf9LsiI1xsEP6NKXL18PrxjDvxbISdkp2SGRlNqcU/Eb39ZFSLfP1+i6tuZtwCeplgv0IUPIxmCSi4klhdOSDCiPSoFAimkFwv2B9Bxw6JoT9l+J26cMfk5Vc6o3QWioQ4nWL7Lp+9B7/+iyS4ON34b5zuVvTdGMHYAuS6GrrJCPaGIx8cHES5DqRET/qq2Hj9eECUIVsGC2U0DrcQn48LNwlkpbncYojV5gqL49UDp+LVxcJ82UWbBPCe5N7t2KFfjY25POJv4Lf4OCjJ/nUNZb4FF8RQNaQbhT5JInA+soIWLLSJcq4IriQM8b44ZlDKYJ02kknQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(316002)(2616005)(6512007)(6506007)(2906002)(6486002)(508600001)(8936002)(86362001)(8676002)(66476007)(66556008)(66946007)(4326008)(26005)(6916009)(1076003)(186003)(38100700002)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWh3aEJjSjE1U0tZUmp2TFc1MUxGL0ZlUEcwM0FiVzcwekVDaEVjNVZmQ2Ja?=
 =?utf-8?B?ZmNVUStqU1laVjBTV0FTcXd6SFdqS1g0Q0VMSmViRzFxTDFmYTZMR3ltTnBZ?=
 =?utf-8?B?aGVaVzArVDFNamYxcS9IcEFmYzR1N0ZHMEdqMk40akxIbHFTbXdYQTR2dzNv?=
 =?utf-8?B?b0JoSGw2blljWFpYQ2RNdjcrS2JDeEpiQ1d2SkkxOXhpQUlOVkc2WHRsVWdx?=
 =?utf-8?B?bVF4NE1XQS8wWG5yV3N6WVFqRGJWNC9uK2EvN3BXRklMc3BwTmFXdm5Oejg3?=
 =?utf-8?B?bzQ4R2wrUVZaZm92MUVHcFhpUGFCTzFRZlZKTEhUeEZ6ejYrYThJc25Ec3JZ?=
 =?utf-8?B?MFZNU1FoMkwwTXpFZ3kxM0ZLZmMzM0txT0FyL3RnQjdZU1R0WnNxQ09INlFK?=
 =?utf-8?B?SU1LL3AwOXNXbDhlbVRXY2ZhbUlRM3FPU0cvaWRTN1VaeWdpMlJhd05zdEpO?=
 =?utf-8?B?N2d2bC9zZ3NjYldBRnZXb1ZwdE9KV1FxVFphYnNqclNkZmM4aVI3U3dodTZC?=
 =?utf-8?B?N0g0ZWVPYVYzWkdXL0lxem9FN3RPMjZUSzFFOU5xSXladUtJUkxtdmtPZkxM?=
 =?utf-8?B?T2FyVEFUYTZtRjFyOUI1RjZ3cXZHc0swNnpXOFBzNkREL3d6NjBDRTlPOXFB?=
 =?utf-8?B?Q2xjQ0NDSUVFYWxMRWpYODlKa1FyRGJ3clZ4L29FdW0zcXpvVUZpc2hkNGYw?=
 =?utf-8?B?eFJYOThhUlZTbmw1c3BPdTBhNHJSVks4bFI1YzB6NFFYeVgxendLZEgwV21j?=
 =?utf-8?B?ZFI4SFM3YXUyL3EwVGVaVHVGaW0wUEdCbzYxUmExT3VNcFQ3THBGQTFjdldj?=
 =?utf-8?B?dnRpaEEvTGlZMHdmNndkR2pNTjZnemRLVFlOVU1CT2lMK1Yra0haWkpmZ24r?=
 =?utf-8?B?YWlOcTdPYWwzWElqeDV4STZ2RGlRYWh0ZnZyUExUU0ROY1I3QkRtUE9NaG4v?=
 =?utf-8?B?anBlek8zV3FMRjJNQ2pBRUtINWxYS0l0S2ZNWHlRakU1UnIyMGhKdDVaQTZY?=
 =?utf-8?B?cGpMWlJNZFJnUlphelBoQU9rcWtNV3BYenJnM29GRnJWQ3E0RUFkV0VXZFFv?=
 =?utf-8?B?aUZza2F4WUxCWTcwcWZNMmJ1RWpEcHRqRVU0N2V6dWtHNnovUEhKbTM1eDFw?=
 =?utf-8?B?b3hMQktETnVUNXpLTnZQdFppeGFrZzFFWDk0YWVvRUVDOVJaTXpNckF1dGxp?=
 =?utf-8?B?QWJJWHd6am5DNno0S2orVVJhTkxOa1ladFV2T3BObUNzcDNQWUhEMTNPVnM3?=
 =?utf-8?B?bVFqRS83RFMvdnZSNVdrbm9tYmhPMjZWTXNidzBQVWFNaHVWU2VyMmZVc0tH?=
 =?utf-8?B?dkZnMDRFbFVWalpESWp3c2FqaW8rajV0TGd4MlorTUxFclFzY2NRU2ljLzZr?=
 =?utf-8?B?dzBwUjRYTng5U3p4bTU2dStaelhvc2dVK2U4eXNVYzBEUGVlZFRmb2VZMWcy?=
 =?utf-8?B?UVFEVUoxNTBFUXVnZkNhVk5MN1kxemNtTXhVM2dFNUtkTlh0alp5aHNOU0FE?=
 =?utf-8?B?WmRGK21Zd3k3WkMwY0FDSUhSV1JsMGhneUlWNG8rM2JQWWljK2JUcmlDRHpm?=
 =?utf-8?B?Y21kQ1kyMFZ5RG9IdkJMUlJsYW9vaGxSU3htclFIUEhnVlNhSnJtY01kMUFE?=
 =?utf-8?B?R21pRTIrY1hadUUwd3ROY0hQbE9rVFF5bjR4VzJZeStDeEVXNVNuTnhHcG5F?=
 =?utf-8?B?L05OTGFpbzhNR0s5ejVMZU4wZ202TGtxUXJDUmtQOGM3cDl0aHJiU0k0elRp?=
 =?utf-8?B?cVBzTTFkcmE1SGdab2VlMTh2RWtxbUNMMHV3NU1kdWxWcVB5bkR3am92cHV6?=
 =?utf-8?B?ZnNLc05hT3JiNkUxYzdzWDNObDBDVURvU2ZOb0ZVYUFYdnp5UnhrekxqSkJY?=
 =?utf-8?B?OE1laElhQ243QmJTWHdQZlJ4Y2taejJSamp0Y0hlTXp3N3pyT0x1MUlKeE9S?=
 =?utf-8?B?eDllaVUvdDRUdHNKcHVmblgvYjV2Q1pPbXJ1RWNoZkNTbzhKU3ZnQ0o3SFoy?=
 =?utf-8?B?SXlmcVpuYmpvU1Z1aW5acGNQMXBIMG9sM0dUSDZONHQ2RGpDbno5bHlmTE8z?=
 =?utf-8?B?N2FMZE03MzQ3U1RrUWRaWm9oY3AxZGNPMVNhSk1Vc2Z1RTVQYk5zL0pzTHVJ?=
 =?utf-8?B?MkgxRTRoL2lUNEE1YUUxM3RwWjV0QnFxNFh2S2g1UEhLY0huN1dmV3VVeE0w?=
 =?utf-8?B?N0YyK3RSNU5KMjVPTGZNUk83QXFtQzFUSDVIM1BUK3JQNkw1MFdTdUZta0RR?=
 =?utf-8?B?WmJST2wyK3M5cDBjZk8wZ3dQczd6dk93YnlIaHM4S2NFNFBLeXNIMlB1NG5w?=
 =?utf-8?B?WUx2NTl6d0JrTjFnTnFzNElESnNWL2JuK1gwNGtiS0JKZnBXZmFsQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e8ada7-6a3b-4551-5b1c-08da3761d9fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 17:31:03.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZrwXiTg2HTOfawJe0tBpi+p8M1UFC8KMzxyonpcDN7OV2SJVmO8VV5qAXBoE03y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 16, 2022 at 11:14:24PM +0800, Cheng Xu wrote:
> > > I think this twice, use a net notifier of module can not solve this, due
> > > to the leak of all ib devices information in erdma module.
> > 
> > I don't understand what this means
> At first I want to register a global net notifier in our module, and link
> the ib device and net device if matches in the callback. But in the
> callback, we can not get the ib devices registered by erdma, because our
> driver module does not maintain the ib device list. This is not the
> right way.

The core has the device list, if you need to search it then you need
to add a new searching function

> 
> > > The solution may be simple: register net notifier per device in probe,
> > > and call ib_device_set_netdev if matches in the notifier callback.
> > 
> > That sounds wrong
> > 
> 
> OK. So using rdma link command to handle the link relationship manually
> is still a better choice？

No
 
> Actually, erdma looks like a hardware implementation of siw/rxe (more
> likes siw, because erdma uses iWarp, and have similar CM
> implementation): the ethernet functionality is provided by existed net
> device, no matter what kind of the net device (due to virtio-net is
> de-facto in cloud virtualization, erdma is binded to virtio-net in
> practice). Due to this similarity, siw/rxe use 'rdma link' to link the
> ib device and net device (including create ib device), Does it sound
> reasonable that erdma use it to link the net deivce?

It is not like siw because it cannot run on any netdevice, it can only
run on the signle netdevice the HW is linked to in the background.

Jason
