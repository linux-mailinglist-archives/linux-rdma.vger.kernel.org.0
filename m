Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3806B1337
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Mar 2023 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCHUiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Mar 2023 15:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCHUiR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Mar 2023 15:38:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2093.outbound.protection.outlook.com [40.107.223.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748E360A5;
        Wed,  8 Mar 2023 12:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nozXOf27zxEDDIbv7cggwbb07wDsTwMc7JLOpYd+e6hirXPFsUcggA76kT4NOAEeHcsC7z3BJIvPK7T01nrIMwv6sQ5E6x/JE1x706iJNXK2Rqq19YAjdTZ1G7+kUdNYXk2Ba9xOMpMWU88MbsSgiMy9v6DDb+tLykNOyQT38yBOfHxVQOqsX7OrQrIS+c3cODkULA/8PIBCSArApGaxn5/k+1R0UsXv4d8DTVsoXraGIq4Yns31HddVC4p5O3KVdgnqNVbM2kJFBuqvC0+EPW2rBkPlnqaLI2oO4OYe2KU6emvMmPpanhWC89OUccthwpdoUiWLKguevy8R5YjEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcwX/KR/1ypfV2kn90HW4kt0ntTx8u8GQ7BnsZFOkHs=;
 b=N73d2nQ0Y1MzWSUfzZkrlEospntfNuUuJeIbWPUG7Dqkh7xFsbVnEWmkM8LDeR6BqN40i5MZ3w2ir58D3p2Q00BktgCIAXbDa/QD21RPggk2qaZcCkmmj8twCkneEP04F1izj7SR2uDxd+rCanPo6fT/vwQ2z5d8lQnPHOLbZx1xBmY+CCEaXW1nLSuHt69xqrE6GEgu68QWHDy/49xU1rqNpbjUfsysb8YNUwUYBFPMn/GSzLHjrOJAR3qRmgEydrgQU5XMsrtZc05av5AIZBCfUw0YDI5nDgu97RZ3CubpzXxqohQobugIyrbufFjdkKuUcHjhKWUMcwc/4L1Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcwX/KR/1ypfV2kn90HW4kt0ntTx8u8GQ7BnsZFOkHs=;
 b=NkL3ST/S4EJWhwXVBjZEJj0ESGqYPHLFBM/HyfICbxWQ3prdEC4hX7l0fLOuohXu2qEt2SatbhmnfUoc8cYE1omTM3I6S89LzJkE2aOTucY413nLyGzla/uDxVsWvpCZsZISmItAW87MY+n1i3/sfcmIPjQocB2vvlmNEgp1Vzrhb8/hSWr6ET1bimPsXQOkMDC5y1t6RF0t8bftzdJu6JAg/Yk7KsCa5i/43dWR/Ltj/hJDt/2qDNDLxAWbToro7g6V8AURFatx0KfPURdwL+J2r1CGw6S7Z47iEVloKsZ3pm1M/UYv+8/Q8df5MbzPpQBQ9zmXNdeebspVcWqAUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM6PR01MB5835.prod.exchangelabs.com (2603:10b6:5:14f::27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 20:38:13 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6178.011; Wed, 8 Mar 2023
 20:38:13 +0000
Message-ID: <774991d7-1f36-7e6b-302c-4436501625cb@cornelisnetworks.com>
Date:   Wed, 8 Mar 2023 15:38:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] IB/qib: Drop redundant
 pci_enable_pcie_error_reporting()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230307193211.874747-1-helgaas@kernel.org>
 <20230307193211.874747-3-helgaas@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230307193211.874747-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:208:32f::12) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM6PR01MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 133645c2-e318-4b21-d4ff-08db20150997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXLBa+C+ZsoQcuGQQU4ugAv/GMTrT1yt9qDKEnY9jtHWA6Gv3HtsbcDgylo/g74nVHCwjxpazolppKxqsMF/OyH8nNoW8LTlw9h6cq2vJxy60YHih3HPBYOn7YwG9a2Qwb1UmGVRRV5nD5JNaJIOqC58evbb0/qr944UII5v/oKF2NJVQk1OAi8TZCCVwTg4eooXHtZ5CaS7DCRTYDdvyMYI7QbjcVTJ+Cye2WpBZQMqFcT2YzawQ1PfRDcsoK1lza8G6Uft5f921ny4XDpPEIXgVl3ZyrDSU2d0sxtGQiVxzJwbgcoK6ipfjr9H05Hrg+rmHy+QpMev3fwAOpQuW5gipZJsHMiJ4wFHXY0SdjG7DoXGipCC5uZiYrrWkmqjhfqpMHCwnsEU7XDM6DZ2Vk2rImexKaL6Ga/w41YXGCsNAXJePahod1QtgEVZoDx2ncPYozeAnFk1usqG74E5qU5JruyTez5BECYZHO7qHOgCNYdTdxaPPrTxM2F7VngLMlo6ulZUhf3fYcP4AAAcDDL3dSeVSsTYPWiaUG6JaZqz4VXMfx6ekggFI5rJ9GnbDCJg07ukvdVLGsh0AkJVv16aGbkt9huhLy+PFQSYnFJU51+5SBfmtPhzBrxAlz3Fzw4M+/TP7CzQLbZvbaCqH4z9l4uMhf1dmUr/lzYht0MDFnGqTEK1sYSAYaaQnHB0MlMuvPPyWXSRDG/y1iCkuTZ+AneLROgC7fiY2PDlWfA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(451199018)(31686004)(83380400001)(36756003)(478600001)(26005)(110136005)(316002)(38350700002)(38100700002)(41300700001)(6486002)(6512007)(2616005)(6506007)(186003)(52116002)(53546011)(5660300002)(44832011)(4744005)(66476007)(66556008)(4326008)(66946007)(8936002)(2906002)(31696002)(86362001)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0h2MU0rQVF6Nld2TjhkUnNLZTc4RzNzNkx2eDZralE5Y2ZGVm5tTWV2Zkc3?=
 =?utf-8?B?R0pZMjBlN0tMUUtYeG1ZOHhCWVZBTThjS1YwUmp4anh1Y21DZUhMWm1ZdFRk?=
 =?utf-8?B?S2xqTE5sMWpGRCtYOGlPb3l0VGlmL1R5dXdqby9TTmUvdy8wQitHREdVcFhW?=
 =?utf-8?B?WnRtbnNETWVtdHE0WVZFQUpYZlhPdmlMY0FqM0MvdmFMd01rWXdyMll1VkNL?=
 =?utf-8?B?azJWV3JLNDBVdERIQ09UQTN0aDZmYlRxekJHRXhuWVhQeUZkeTZnQWdkVHoy?=
 =?utf-8?B?WUo0R0x4ZmNzeGVJTGhrUmkwaFF3SThNUTFWOEhhWjA4T0F0UStqd01Yc1Qr?=
 =?utf-8?B?ZUZZYkFrbHllWXp6Wk5ocTAwQ21XdzNtaHdRK0Y4c01MM09pQmhTanZBTVFo?=
 =?utf-8?B?VXB3K0Y2SzFMZFVBNWZtM1ppa1p3WlpmUDhJcTQwbWMwa0t2NWJSWmpHeTY3?=
 =?utf-8?B?cHhXNmhuRHlTMFVjcE0vMnordDQ3cmg0VVpJTkhTT3lpMDZFc291citKV1N0?=
 =?utf-8?B?ekh3VUh4OTJyc3Z3UlUxbytmRllvY01GUyticUs0RTRxS0EzMWlsbmtLWWJO?=
 =?utf-8?B?TWd3a1F3UkJOUjR5NUU3Z2FFUXBqRi9Ca1ZtekxjMmhkcFZzNnl0QXRRbFBi?=
 =?utf-8?B?QUJPY2tDZlBBMTFWRlkzN3RPNDBHTG5USUQzd3I3QnZVTXhUWmFhMjdKSnVG?=
 =?utf-8?B?VXVKNmYzTk1NSnpJME9CcGV0OWFGR21mQjFjUGd5SHRIQ0JZV3MvTHZvSWJ3?=
 =?utf-8?B?TkdJUWRIYmorZnlsaUNKbVM5Qm9IcWxvbVRaelo5UEkwMGlNMTB2NHF6aTR4?=
 =?utf-8?B?QWFwRWQyMXE0Szh1SWE2M3FQRHRTQ1pwUG0xQ0hReDN2aTlJU3J1T2p5ZW5V?=
 =?utf-8?B?eEFEQWRKSGdZYjZiMVRVS2dUbWFMVVNSWnYvV0RlR2dtblc4Q2ZtaFozRi9h?=
 =?utf-8?B?TkJqeUpkLzdpLy8xRWl5ZDNIRzZIOVlFL3FPOU5nNi9SOHFmOWJGemZVc1M3?=
 =?utf-8?B?ZXpYZ0lvNXh2OHoyTno3OUVPZEVxMjVLL0NOZi9wRDJ3Nk1Ic0pSUlpVcVds?=
 =?utf-8?B?QjI5eG52YllUVlA3VTZVVEgwSmtwVXI2aW1BNjJHR01TeXBUUEo1T05oWjRy?=
 =?utf-8?B?WjdmSHRvZ3RMaDlSZkd6bGdSY2NTaHZzUXROZUpyZCtVS3VJZE9jalFOQmdx?=
 =?utf-8?B?TTROY1hYUTNJZlVIVjZoV0RCNjlsWmxqbGEwalg4MEhIWE8wM1AwUnc1V0tZ?=
 =?utf-8?B?N0tkSDFiVDNLYXlVOHJLZFBXSlBuTnJEN29SdUZlU1JBQUZvOGM4RlVXYUp3?=
 =?utf-8?B?V0tVTDcwZEJHbzZob2g0eXVXR3pmUUFPR0wxVkdwT1RrQWt6MDdZZnhBNTVp?=
 =?utf-8?B?ZkptUmw5SDdLVzhJZFJuV2E1eHF0TFZmLzhVTm41UU1uR1FwRmNkbUhjV3Nj?=
 =?utf-8?B?cmF6S3NPRVVwenRXdXdqQmcwZnhjVlg2YXU2NW5IOW9ManZqMEJ1cVJzb2pk?=
 =?utf-8?B?WnNJV1IzcDNUdDQ3MVZmdFRYYTZueHhjWEx5SEwvemRBNXBES2g4bzQrWEg3?=
 =?utf-8?B?VVY5WEVGK3lZU0RKT2xTNUV5RlVVTzAraWRMb1NiRnJyUGdKNldCUDZHVEQv?=
 =?utf-8?B?Y3c1Sm5aUDZ4MUtMejRnQXNvMFQxZ3A3Nkh6ZEJGUFNoYUM4TEtId3d2Rkx2?=
 =?utf-8?B?cWhYaVV6K29oOERGZzJ0QmFlNWFvd2ZucGFSZGpZTGcrSkswa3NnNkJHQnMw?=
 =?utf-8?B?ZS8yMDN4TW1La3RlZHFscit3aXlHc2NVbFNrUkRyWngxWDVNbkNBVkVIaGda?=
 =?utf-8?B?OW9SdUIyTXdibGZOeHp1S052SGN2UEkxck5ZQm5DcU1uTXhRd2s4amd4djhw?=
 =?utf-8?B?cGdMZnIwL000YVo5alpkN1BnR2N3d21TTWhpVktUaVBzQmZyNzBKZlJUdHZt?=
 =?utf-8?B?aUhEU0YyUWVyTjVQSFdTVnQ0N21CeUpEL0Z6R1MxNHlheXROazRIOE5mVkg1?=
 =?utf-8?B?d2VlREs2eDlrSjFrMjJUT3MxRnFxTkx4Q2xWbDcybnE1Y1FWV3lCemxhRUI4?=
 =?utf-8?B?R01MbklOZXlCTytCTTdvVHpkQjlET3ZKNllZK0dBclU5M1FkaUZadFU1NlZ4?=
 =?utf-8?B?YVRvS0dhak9hK2h1RWYxZ1NpMDU5TjFRVk9SRm5nZnRMUnlka3JKWUZvdWJy?=
 =?utf-8?Q?ROzAl0z+f+bMnL9R0HnUeZw=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133645c2-e318-4b21-d4ff-08db20150997
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:38:13.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsMHuSrcTKcHNTHbnXErAgmWKVRsSw79/gWMYm/fYYPJTUcDmsEHX4l2OjaVFaXKeWyShsDxTHGECx5l2KJJaTaE7LxeMxpeDzNEwgpRt5bJSTDSuxQFuXH2cX/IPBTk
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
