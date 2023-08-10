Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B448D777B10
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjHJOoK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjHJOoJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 10:44:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339226BD
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 07:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/2feOCvfR1szjnDXi0+tgR5FnmXqrT0Z0f8RG+zfIR20ttllhGgiZVdaZmj/eoUL9j624Mdk3ifoTB7a5AabpBF/fgolu5ZkmEa3vrI2paOH/2YSWqtAiT/FTHVeGV9IoCsxehroQ+QH/wDWGoEEGKkcV9KlMB8uxPYVTqweIeU63IqQJBVmgWAqxATsNr9Nju4WQKm7MkDc5kxcer/staAHhbZAiqYbGAOHiN+4YCk4G+5E8gkcSObgXZPUQNM+6ufVbwjRRCtBa+nwrGs+97Q5lTi4O6d+6qSGlz9QvyXxt0n+AcwvMnMsUWbxa3AQiF+xVWIWwI60EjVarTZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7zIwbQRNeFFELAX5P1uzs2nBx/enkMWm1WouDpW/Do=;
 b=Jybub+sfVPC0Me2YYfKt8j1BhtxmV/mB4V6JU1dvmXWhu1WX3y6rfGihxATYq2ITicYox+7gD0kywob/s5WUEx+kJvi4OgwwG+tD9b52DfzwzZi2qowBvnQD6+jpNsR7mwMLyM6KeMKqLZerypz3YwBKAh4j2NOiAcb5Z1MDrzbo8+jIysZhldYGRPB6GSvbROYCO2YZZdajpCPorni7DxwmDd2uANu5O/Fbn26JkX/yM9ODgnz0RktgGO1L9VV0x9cnHcAe+XGRVO5kO5b4cTKd3cqo4jBpifCJP0/RdtgVFc5tvkZcRPjnhce9nyTz83wmiCakGL+9LLe1Bc0tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7zIwbQRNeFFELAX5P1uzs2nBx/enkMWm1WouDpW/Do=;
 b=Oe1W/RmRN1GdI2ZpnebQMcDGbQUwhD0QAPBkTFJUM9bNEpmSPf4No7pnWCJqdVLLMtyfywHIkWREehHu4L1rw1ZiUfXRhNDHEuVhn0/hFTX4jfFcx+hYzpR99/B1AIQwpYWs41LrUIZOOmbLxZM2l+XpD1gS2rzIWJaW4KcMM49PFUGWr4XwG7+zxYk9XDDccDTA2s5ixGX/WuEk62WpkGDAwzfTfPFaWY616E4Kxn25jE8750C0hSDEJhgtyJm3Zuu3qblCqtljr/HJaPKxVfmUe6Q2ZNkCfc9dbhuHUBk3nnqcZ4u7bMpBbuIQNhhXPMEEIsybl8pk14T6n8jPdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 DS0PR01MB8033.prod.exchangelabs.com (2603:10b6:8:149::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 14:44:03 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 14:44:02 +0000
Message-ID: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
Date:   Thu, 10 Aug 2023 10:44:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To:     OFED mailing list <linux-rdma@vger.kernel.org>
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        saravanan.vajravel@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: isert patch leaving resources behind
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::25) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|DS0PR01MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: db7d4702-b555-4b0c-b54c-08db99b03d6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bklOAeppdqPDTx/+6mAqXIYbtL6CVHur4UGnWe8DHPtOJd/IR1XtITGMXsDitKJDzT4I65sDoEtL7B5FHvbyH8LE7q7SsrUumT/zVpHNk1FxMNISdA+Lvfta6w+iyYPpFn/q2nPhwkOLSZOO2EbQ2FA7Ky671E25Nr3kin4cBogeu9Df4kh//LXgZZKWTNQy3Yv1UOkPU7FR6Shs4+/2oSbjH75Q8DwWSwJ8leG+EMYz0DzOvua1NeF7Ttsa+EBEfLE5OLrY6ChUEn0KguXKTBXTfcaBiLKS1kYKKm/P2sq3zJsEwlhnvoF1f7PJFwtpNmlCJuN+d+E2+iZA5zrKRmn3L4Swl1a4kEosozv483M+fE7CrpSTpGdoNUD1lPVmhjAsuJoFBmQbo7Pzwaqdjnug8+s/YAyuJL7Xrd5Wp94BBIEjsnNx/udgt+f0kUZjNoXgxTQEiuduMCuNft3BqFETT6FcbefMKEVcjc9ioJwNgzuMWNfeDzjDAi58NUMZRf1F0vVNyt3nidz0R+HzbYOymXN45zV0k9TpJmYo9Z3jQCQp4wDf8Q+z228i8osmnaT1VTsYJmBY56NUEZEIwyT87wx4GB3tr7ZqzHMMWNjKgZvsPTwpNmWozIxhURxgoZuBjaGNOwEZHHlTSdfRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(39840400004)(366004)(451199021)(1800799006)(186006)(26005)(5660300002)(6506007)(8936002)(8676002)(41300700001)(36756003)(2906002)(83380400001)(2616005)(38100700002)(38350700002)(31696002)(86362001)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(31686004)(6512007)(54906003)(478600001)(6486002)(52116002)(45080400002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRwVytIU1NqTVpnOWlERGtTdk5CZytVdkJRVWUzQlV2UDAyZ0pTWE9heUhE?=
 =?utf-8?B?cG1NNFVaL0RaUkRmTlZwMnVNTmtuSjEwUXpPbldiOHBDbkZSK3duVnpoeWNt?=
 =?utf-8?B?SEVVY21jTDV2TWV6cGd0TzNlRW54NCtReUE0N0RHck1ISUJqT2IyQ2lXcFNB?=
 =?utf-8?B?akd2YlhqajdwWnB2REtYVTZ2V1Q1RWtqT0tNTWVGTEFWRjVWUklhQlI2V2ht?=
 =?utf-8?B?UHZQY0tmUHF2S3lISUVibnRkNUM4aFlHdndoSUl2bzNDWldwc2hBKzVvTW4x?=
 =?utf-8?B?QWpJYW9VV1MvOGYxU0FNSGI4ckVVdDhGcFJ4ZkVnZktoTWVPSGpWM1dyU0tB?=
 =?utf-8?B?VlEwQ1RLSEpCbExBT2pGZ0Z1TkdvUXRZQmZiV3Rnei9JY082NmJlcWg3d0RM?=
 =?utf-8?B?ZlovaHYrbjlUNWFXL1RvMmRNTVNxWlFaZ3pnZlVxSFU1d1g1ZTVRWDBVZURy?=
 =?utf-8?B?UTh6a3YxTk5PSUgzUkJ1SHNCR0UxR01Za0QxRWg2QjBma0JmYmw1Q3VUUWRz?=
 =?utf-8?B?NWRaTzl0bGJCZ2RKMGFGMWJLaUorMTBDSnVDNEZwd05xU3lXSGpHdElFa29V?=
 =?utf-8?B?Z0RMT2xOVC9BM1Z6R1dqYU5JdHpLd0g2WStEdTQ3ZVhvSnVZWTVkZ0pXWFV2?=
 =?utf-8?B?MFNTNkE0TjM5N0FBSzZYUDFtbjk4dWlBd1c0TUxxVzk5MDBpbHBidlhxTCt4?=
 =?utf-8?B?emdyWFJaTVBlUitHOHJZY3grS1BkampQdFZpalFuUTkyNVYxcUhWSjlvYklt?=
 =?utf-8?B?VVRSRyt1czMwVmVjc2lraFpYNXBEaVNRanZVbUtSdTN2eGtVa2hZY3NpZXl6?=
 =?utf-8?B?TGVFdDZoaEtSeDRibHVwUllPU2tTZGZEd2pQVThZV05lYzZSVlBaRWl5MG9H?=
 =?utf-8?B?bFdKdUo1OTdTZjVpdVdSSXpmdEpJdlpiWnhyYU1sVjJnZHZaUEs0OExUR255?=
 =?utf-8?B?Z0tjWm1xUUlwaE9aenhxMHZJbnI0YUE3VVhwT0VFTUgzL21vRkxYK0F0a1dy?=
 =?utf-8?B?cHZOQXhwd1ZHZDZVOHpLR3RoOXNYOHQrOG8vNHR1cEpSTWVWYlhQSFdGdmor?=
 =?utf-8?B?RUtOOXRDcE1nTllxOG9IZXl5WTljOFoyN2Y2NFlMNlRIMHhjbmdrMllwTTNJ?=
 =?utf-8?B?ZTdtaHNubjRJL1JHWjQrV1Q3azhBQzZtai8yK0RIelR5RHk1SzJyYTVHY2l2?=
 =?utf-8?B?NGR4cnRjbmxPM0FidHdYTFNka3A0ekNwY1dOK0JhREtDRU1pQlBSME84SHpU?=
 =?utf-8?B?NHlST3U2eHVMVFFYRWdjZVJyaHArZzE1SVBhK0F2Ulp0aVJFaFhtNEVuWEI5?=
 =?utf-8?B?aFAzZHZYRUFweW9GZlNnQUNQUFVQSFd2Z0hyWC9Dck9XZThxRmFFbmFjY1JS?=
 =?utf-8?B?MzVaZjFvcTJCVFYrTFFoUmpmSVowdE5CWXlxZ1ZwTkxHVTQyZ2RiMzJlZE1x?=
 =?utf-8?B?b0FpSTJ1MzY5clpqbnlPRHF1M0VKMU01OTU1cWdOUFJjcm95eHVlZWxBbkI5?=
 =?utf-8?B?TEpvMjI4Z29LVGt6VHBRaW9DeW5Ocm0yL3F3S1pKRVlWaURJUFpPYzg0dFhJ?=
 =?utf-8?B?R1BhaGtjY1dkMERrV0dxMmxEVXIyN25Md3A2cVdMOU9pVUdiN0xTQzVtNEw1?=
 =?utf-8?B?YzZ4S2hKTTJzNW9EVVNzTlQrNEJTYStib2tIREVMU2FrTHg4eFNEeUo0MGxZ?=
 =?utf-8?B?OFJCZmxSdkpRcW1qK0ttU254Rm13bFJDYXg5eVJYZGdhNzg1OThoajJyRzR2?=
 =?utf-8?B?RU1yTjljeHdselJFVlRKcGFDRXpwOWR2L1BKdFNnbytVVFMrcU5Mc0drclNQ?=
 =?utf-8?B?bTFsc1BvdCtXSHNvVEFRd3ViZGkwSW50SThHWHZkOURkK3hMSUxLclhJcWxP?=
 =?utf-8?B?UElIajI4YThRVmExVUJ2SjV1MHM1T29JRmlPOUo2TWZPeVpmT0lxSUhKRFFm?=
 =?utf-8?B?QS8vano3RGd4V1grVGE0d2JXR1FFb1lqa2d5UVBrMjYwVmwrcjRMTis5am5Q?=
 =?utf-8?B?bHFxTUtKQnlNM1VESFpkMFZiRndSOVg3d09rYk5mUGYrRUVoRG41RW9MU0JB?=
 =?utf-8?B?NnEwMXUwYUpoY05vTGVvblVEV1hhUnpmRGxPWVA4RXlDNXdmeEdGTlZTcDFD?=
 =?utf-8?B?Y1RuYWc1MGh6V3pBbjh1S0VBSDlCd3ZtVmpVVU1JdGRpL2kyUWhlSUJwaEYv?=
 =?utf-8?Q?ntfLcGs9Vwqph5pOWDpLoh0=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7d4702-b555-4b0c-b54c-08db99b03d6b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:44:02.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZg/8FiJV0Hwz0CFa1lIKKEDtr8lfks4JhZJmEFlt0LvEfFTBvav60sck0CURXyNk1+esjouR+Ahyxtcklk5RvOIIcWSfh7KMoeuEtAGjABnlvvMDEcEgyH1jLwv8EHN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
causing problems on OPA when we try to unload the driver after doing iSCI
testing. Reverting this commit causes the problem to go away. Any ideas? Was
testing done on this patch with removing/hotplugging drivers?

[29151.413816] ------------[ cut here ]------------
[29151.419086] WARNING: CPU: 52 PID: 2117247 at drivers/infiniband/core/cq.c:359
ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
[29151.431096] Modules linked in: nfsd nfs_acl target_core_user uio tcm_fc libfc
scsi_transport_fc tcm_loop target_core_pscsi target_core_iblock target_core_file
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs
rfkill rpcrdma rdma_ucm ib_srpt sunrpc ib_isert iscsi_target_mod target_core_mod
opa_vnic ib_iser libiscsi ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm
ib_cm hfi1(-) rdmavt ib_uverbs intel_rapl_msr intel_rapl_common sb_edac ib_core
x86_pkg_temp_thermal intel_powerclamp coretemp i2c_i801 mxm_wmi rapl iTCO_wdt
ipmi_si iTCO_vendor_support mei_me ipmi_devintf mei intel_cstate ioatdma
intel_uncore i2c_smbus joydev pcspkr lpc_ich ipmi_msghandler acpi_power_meter
acpi_pad xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg crct10dif_pclmul
crc32_pclmul crc32c_intel drm_kms_helper drm_shmem_helper ahci libahci
ghash_clmulni_intel igb drm libata dca i2c_algo_bit wmi fuse
[29151.520056] CPU: 52 PID: 2117247 Comm: modprobe Not tainted 6.5.0-rc1+ #1
[29151.527759] Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS
SE5C610.86B.01.01.0014.121820151719 12/18/2015
[29151.539462] RIP: 0010:ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
[29151.545908] Code: ff 48 8b 43 40 48 8d 7b 40 48 83 e8 40 4c 39 e7 75 b3 49 83
c4 10 4d 39 fc 75 94 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b eb a1
90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
[29151.567086] RSP: 0018:ffffc10bea13fc80 EFLAGS: 00010206
[29151.573040] RAX: 000000000000010c RBX: ffff9bf5c7e66c00 RCX: 000000008020001d
[29151.581120] RDX: 000000008020001e RSI: fffff175221f9900 RDI: ffff9bf5c7e67640
[29151.589202] RBP: ffff9bf5c7e67600 R08: ffff9bf5c7e64400 R09: 000000008020001d
[29151.597280] R10: 0000000040000000 R11: 0000000000000000 R12: ffff9bee4b1e8a18
[29151.605360] R13: dead000000000122 R14: dead000000000100 R15: ffff9bee4b1e8a38
[29151.613437] FS:  00007ff1e6d38740(0000) GS:ffff9bfd9fb00000(0000)
knlGS:0000000000000000
[29151.622610] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29151.629133] CR2: 00005652044ecc68 CR3: 0000000889b5c005 CR4: 00000000001706e0
[29151.637212] Call Trace:
[29151.640063]  <TASK>
[29151.642500]  ? __warn+0x80/0x130
[29151.646209]  ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
[29151.651997]  ? report_bug+0x195/0x1a0
[29151.656191]  ? handle_bug+0x3c/0x70
[29151.660190]  ? exc_invalid_op+0x14/0x70
[29151.664574]  ? asm_exc_invalid_op+0x16/0x20
[29151.669352]  ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
[29151.675107]  disable_device+0x9d/0x160 [ib_core]
[29151.680399]  __ib_unregister_device+0x42/0xb0 [ib_core]
[29151.686361]  ib_unregister_device+0x22/0x30 [ib_core]
[29151.692128]  rvt_unregister_device+0x20/0x90 [rdmavt]
[29151.697889]  hfi1_unregister_ib_device+0x16/0xf0 [hfi1]
[29151.703936]  remove_one+0x55/0x1a0 [hfi1]
[29151.708588]  pci_device_remove+0x36/0xa0
[29151.713076]  device_release_driver_internal+0x193/0x200
[29151.719035]  driver_detach+0x44/0x90
[29151.723137]  bus_remove_driver+0x69/0xf0
[29151.727619]  pci_unregister_driver+0x2a/0xb0
[29151.732490]  hfi1_mod_cleanup+0xc/0x3c [hfi1]
[29151.737516]  __do_sys_delete_module.constprop.0+0x17a/0x2f0
[29151.743844]  ? exit_to_user_mode_prepare+0xc4/0xd0
[29151.749298]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
[29151.755527]  do_syscall_64+0x5c/0x90
[29151.759631]  ? syscall_exit_to_user_mode+0x12/0x30
[29151.765089]  ? do_syscall_64+0x69/0x90
[29151.769374]  ? syscall_exit_work+0x103/0x130
[29151.774243]  ? syscall_exit_to_user_mode+0x12/0x30
[29151.779716]  ? do_syscall_64+0x69/0x90
[29151.784020]  ? exc_page_fault+0x65/0x150
[29151.788499]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[29151.794245] RIP: 0033:0x7ff1e643f5ab
[29151.798336] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83 c8 ff c3
66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
[29151.819504] RSP: 002b:00007ffec9103cc8 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[29151.828109] RAX: ffffffffffffffda RBX: 00005615267fdc50 RCX: 00007ff1e643f5ab
[29151.837575] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005615267fdcb8
[29151.845654] RBP: 00005615267fdc50 R08: 0000000000000000 R09: 0000000000000000
[29151.853739] R10: 00007ff1e659eac0 R11: 0000000000000206 R12: 00005615267fdcb8
[29151.861817] R13: 0000000000000000 R14: 00005615267fdcb8 R15: 00007ffec9105ff8
[29151.869896]  </TASK>
[29151.872423] ---[ end trace 0000000000000000 ]---

And...

[29158.533739] restrack: ------------[ cut here ]------------
[29158.540002] infiniband hfi1_0: BUG: RESTRACK detected leak of resources
[29158.547499] restrack: Kernel PD object allocated by ib_isert is not freed
[29158.555193] restrack: Kernel CQ object allocated by ib_core is not freed
[29158.562801] restrack: Kernel QP object allocated by rdma_cm is not freed
[29158.570395] restrack: ------------[ cut here ]------------


-Denny
