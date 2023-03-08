Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEA6B1334
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Mar 2023 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCHUhs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Mar 2023 15:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCHUhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Mar 2023 15:37:47 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFFA92DC;
        Wed,  8 Mar 2023 12:37:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzlI7u9nCVbn8STd1T8Gj3/jJVV7VUX8HC9/zZ/UVPB4ezCFiGsn7T56R82Ln4s0laxDewvPSleDFAyDGE0YzHHA9sgbHpIoJA+vhkvtjLELBB6fwNMAtGP4fLJ8XuEqwlXKObprmmO1D+yvVqLWjiLi4tjUt4WvMIiu4gUSzwxDYNOPbSnUcYupyDeHyqwu2b47j3qqIZfYfsLf8HRMQpMRN0a4TLu2+uwcSGifFy4oXMdLnKjF/wHf7YzhbR3i/Dz+lSYuX+kwOX0uFTpWM2sPQJ5pKadwF5X+NnizfmdK/YL+SezVNzXJ79+BtqwIN3J8SWdeMOwbNLnWWEHt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcwX/KR/1ypfV2kn90HW4kt0ntTx8u8GQ7BnsZFOkHs=;
 b=HYxujU3RHBjQ9qKGAtKrr22t7ez9UbwnDS8qsF86KfLYn8nvvEIV0aKUmax0NhJT3yznOWP9T8Fe8qqUTDby/XrHQtEOi9g+hkUM7W/n+O91VGUhyg5xvWTrNFaui8/lVJB/pWui2D2PIb0LTSSOnBZSJ6eyDyb4XOyodSpXX1bQVlhuuChcx6kX/BNHf5V4GK6XZpWFEe5Kg2FsVB3REo8ghmQpG9wbfDadtuiRNap8BNfDXn5acXg4ChtrYvLBDdU2WQz7EV+M8ZSwBxm5IHV/pYVo/Yal08vkL4bSUlhtQcovQZ3qMneYOFWDF6VnbsDWpvG8Aew9Ha66X6eBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcwX/KR/1ypfV2kn90HW4kt0ntTx8u8GQ7BnsZFOkHs=;
 b=W3MQJB7paMfwDrlJ5Xv8yD7YR34klIxOiYu60UMyagMBSBKbYSCpBgZ3WaDDgMLNNX42UJ7awd5iFrn2nETiPAUF/Nf9Cgqhg/Y1dT7fZutQndqXO/NBs34ijNw048togA81s9dQjKnxx/1UnpRdObnhrkqoQk3kGH8wV+H57wxL+ecv7vujycJtIbZ0BDPLdPZPGuY7JGRQ7jAzGhba+bmImh4f45O1phcZKlQh5zNrDL++D5s5poG5xIlXMtjqkyT9cUh4S4l5D1rOKdGViAewopFu1Zm1ZSAHgq4QoWqXiJEQELAjxNDJg+w++fK1uZXLg/BZcmsbsgQlScQIMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM6PR01MB5835.prod.exchangelabs.com (2603:10b6:5:14f::27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 20:37:43 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6178.011; Wed, 8 Mar 2023
 20:37:43 +0000
Message-ID: <67b59032-c94b-e69e-57ed-45784e809df4@cornelisnetworks.com>
Date:   Wed, 8 Mar 2023 15:37:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] IB/hfi1: Drop redundant
 pci_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230307193211.874747-1-helgaas@kernel.org>
 <20230307193211.874747-2-helgaas@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230307193211.874747-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:208:32f::16) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM6PR01MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9d93e8-4590-4494-45dc-08db2014f7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gkqL2Pd0bnHuEhtNO5wV94gnhaILueBaPXCMNtffIs5SZEC2I5+k1zc4m8bAzpp3MsoHYCgjL5xxqf0n6ZYzwkEkd7KTYXjWcgeFW98gabOeftD6TXikGXK15n/yO0I5GCoioQTvFe/qVYXvyY1yDAL9LG4KEIZHtGfD7BzoWpbgiOFb6S+MuWA42y05c3srDEA9dJ3QZiIX/wEuUaQuSkcuxu3GMHQFBsk+aEksLd2aD/gTLQSY8pQiDgKHLOAklXj03JsBwhhYVs2K1iZrjgTwY6VgPv4ViaWUUjg3Z2xXyQU4QRbPOvHTVh9azEmtd0LP0b08WBFpaoYEA3/1co2mTvQVqyNh0KEicVxWVnX3IQDrTZhUHULyy0NfukC2TU8tbBToW1CsfGFquX/AfzG6CHddRPNaAnIQfIgarUGtFRHDycgXN89oOx9enxajCPmhoPh2IYUPqz8OkgcwwTf/gA2yBSXFYulGRVA7HjIA3LpV60Jm4tH/RKY8GzSezc8LXgbcuGn92qNF9qTzTu8S9gM4I0zim0r9YBcIp1fzvYofXEkZVfg3UEiegpV+DShY/obCQVnDTYpLWKqzdX/9NCiPMQMVouYpz3dyO4qeJ364em8hnhO5MtJFTSC0NYTWnZBAMWog4UfA84OfmI4EXj/+9UQdnUbp9re9MyaIifdBxQcdIOUgnT9e19KdjuSEmOpqU/zXAna9uwTQdH5eRF9ZfilYw+OH7bk454=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(451199018)(31686004)(83380400001)(36756003)(478600001)(26005)(110136005)(316002)(38350700002)(38100700002)(41300700001)(6486002)(6512007)(2616005)(6506007)(186003)(52116002)(53546011)(5660300002)(44832011)(4744005)(66476007)(66556008)(4326008)(66946007)(8936002)(2906002)(31696002)(86362001)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmg0RFB2U0xlMFFlQTVsME1XWXVaVHM5R1I3UFI3UWhkdTc2dTQ3OCtqdDhy?=
 =?utf-8?B?VERGVlhvRTBMdFRiR1M0SjRwN21hL2F2WEZSR2Rrbnp0dmpHUVo5azZ0dU5T?=
 =?utf-8?B?S2JISDVWQ2x2MEFyZGZLLzhMcXNUczhoeUFtdW9Fck02UCtmcGtxU0o0bnJD?=
 =?utf-8?B?QjFKeGlkM2FYZTZFNytqQkM3T2ZPWVpscDljMThJUmRDa1YrTUdCSUFDT1lH?=
 =?utf-8?B?NHBlL2plWGF4aXVhcUoyTm5lMnI1UkZVeEtjeXBhbHA0QTBESzVhekFsTU1B?=
 =?utf-8?B?WEsvU0FBYk51T2RKQUR0czhBL3VhSjFXSndXVU5Ha1lFNjVFYk83QWgzK1dl?=
 =?utf-8?B?NjIzbmU5cDVWZUh6NENDY0dTN0x6bHFNcWlTL1F4YWYwL0NtTk1EK3RHZEJu?=
 =?utf-8?B?MVBqRzhLQjVDMjVuV09sczNBamp4eElxd213NElaZFF2cVpvWG5yWnpVOWFs?=
 =?utf-8?B?aGlHK21KR1RGQm9ZdFd3VG9nTFZDcUNZVTdTSGFra21CZ0UyV0lxZVEvM29x?=
 =?utf-8?B?R2YrQXJqNlhocHE0dm1RWmF2UlBDWjRHOEUyTXFobnNtcVV5RkViSXZyeVB3?=
 =?utf-8?B?SUh1OWVJYVFwWHhGRUhmeUFWbDh0dXZjcWRNTnJwU1U5emZ3Zk9VVUs3REFF?=
 =?utf-8?B?T3FOeTMxZGxQcEduRjMyZXFnWWtOb2UwNmdhVHFSS1hpekFWdCtEM2NpakdO?=
 =?utf-8?B?OHNVWG9aYjdjM1lkbXR1QnJYUGx1cnVCaEJRQm9MSWd3RllWdXpRbmxiZVdF?=
 =?utf-8?B?VzJxaXZIaEQvaEpyREVkbFhRby9BSS8vZ3J2d0JMU3ZIQ0pPU3A4eXQ3aWpq?=
 =?utf-8?B?VXZjTzZmQVh4aFoyc3U3bmtCcCsveTQxWVVoKzJYSEtlcGxzMWIrRHlMUzRX?=
 =?utf-8?B?dzRxdGRidUF1RGF2NWNTbXRPSVRwNFFSRmtLa0p2d3RDaWxjWWVuTFdjSFVt?=
 =?utf-8?B?Qk0vRVlORUtITTJOTGNTelhLRHh3dFZNR2lOSXVtckVwZ3REZ2VDZmFOdERm?=
 =?utf-8?B?RFB2aWhxMTEwUUJBNHlUbzdPdFA1cHBCTXJ0T0VDOXNnclpjajBRMVJnKzJi?=
 =?utf-8?B?L0hUc2R4R3BnVXM1WFNKZ1JxamdJcEZhSWV4R3FTS3JtclU1MmdMOE9zWWpH?=
 =?utf-8?B?RjdEQThnbWNTMEJFdXlaUngwMXJUNnhIaHlmRTJZUENPYmttSVhETU9jV2xk?=
 =?utf-8?B?R0tDUGpMQ2s1dlhlOTZFRlhWVFB3bFVDS2JoMmRFU0hKcytDWU5YK01JR2FW?=
 =?utf-8?B?SThuckF6R3ZRaEJrNkNWSzNmY1dKMFVPMjhibnVLQ01PcVVSNytmcmVrMjM4?=
 =?utf-8?B?cjNpd1N6KzF3Y08vbHgrUTdXUmtrTmFQaHJ4NnhTMUJrbW5FbjBic3RCbjRG?=
 =?utf-8?B?UU9FMnA0SVdrTmFGMUdYYlFIang5LzRWc0I5aGVpSXRQZm13cjFGNDhkTjBs?=
 =?utf-8?B?VDd3YjJydGNBREZqOGVzcFlua1M0SzVjb1hoTGgybHVRYUdwZm81VTBITXJP?=
 =?utf-8?B?NHN3L0R5blRUdGRyWG5sdEdCemg1NFdHQmk2YzVPcjJIVVZjU1AyRXRZQnMw?=
 =?utf-8?B?Z2tJUWsvR215SEtXL053ek9XRTZZV25hdys2WHM5bnMxQXY0NHdwcjU4MXZW?=
 =?utf-8?B?bkFNVG15YTBOMGl2bS9YWngrTkZGUWtQdjN2N2pxbTloZ0FIZ1k0R0MvaHNW?=
 =?utf-8?B?WExQaDluZSt2Wkh5OTBsTTl0WWdJTmlYd0xrMEc5UmlmMDh1bXJES0l0c08r?=
 =?utf-8?B?QWlaWDAwTGFxV3Y0dTNQN3VycUVqRUYyNEFra2xnbFFnY2k4MHV6U2FRSUM0?=
 =?utf-8?B?RTlyU0tSMWhNQzFVR0F0UGRSMHB4am1BcldrSGw5TEd6ZFU4b01yNEJ4R3k2?=
 =?utf-8?B?a3RUZ00yVlMraERLek50WXR5M1UxL3diRHRMNjYvWkJmZUpwYnRhNTZxTUhj?=
 =?utf-8?B?ZE0yN3lLcE1sdXA0QjEwbFBrOGkwZ3JQcGkwTld3SE9XODlyWEFnbTh0RWU3?=
 =?utf-8?B?RG5ORFpZTDd0R3g0UUNDT3pCVjZiT1NYSDFaaWFxUjVwU3FkOFBYNzNlQ0pB?=
 =?utf-8?B?cm9IV2o0SDJiQ3l5ZWlBajIwZHVrYnk1NEdUQ1dzd3dQRFBOZGZKalk4ZEJ1?=
 =?utf-8?B?TjBSTnMyMjB6NEs1WUZuSjVvNFpFWUdTRjdXNW14NXJoZ3htdkRaV0RTMGox?=
 =?utf-8?Q?knJEXipbD3dG2CelQIOeC5c=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9d93e8-4590-4494-45dc-08db2014f7da
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:37:43.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BvqWwoum3fe3Wp4ee52N+1gQ3zdSWqga16HbFLOgTrsVDS8b0lj6VvMs4f/8r4WhzWT8PmnwrqVWBvHxu2gnszU2BFEI+ICAwfey5jhWGfv5ljbDdRd139MTDNSO7bb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5835
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/7/23 2:32 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
