Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B802C78425A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjHVNt2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHVNt1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 09:49:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314E18B;
        Tue, 22 Aug 2023 06:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF1/4fL4tFjdEtZVCiEjgsEI8lbnydQOkiyVFODpIJ0Kt3tTs33WWsg612R0NGeamz8/0DNmxU41iY/ZZ1+sWfk9++/bQLo3gAdAdHwtjvlYuutx0tCKW5wUaqNy6oPo/S//IW+9V95BbhtyEPoSpwkmvIJ8HSi/JXUuIrMH3HcEKUd69/80LcvqgR1+kMN2tjYWp9WuF46fnPtmx8H4VSBFvUC8W3uU+SmeE4E/Sl/e/Kf8q0MGyfkqHz0n5JT2Plm6ywrH1BSoF52p6nrBEI8PW62KrSDX06Lhtazy5H3XqkZFo7GYXhf0E4ziJYQh6YuIh7oqS4Ft/t3iTtK9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeeaRpDQK4tqN5/ogMRi43cFZH0sgAJwvKKcOZosNiU=;
 b=MwC7D85BxVOBQOvqgmjsz6EDE3BmqookJkYdVjgnW2kzm1l2vM1RhLO8f8hvr8YrZCAJ9NI/D5T5urfdk5plTVcAD5IZ8IDLPB+YsYXyALwhFpju/yuurfRlZlmM5FmaJbth/wtqvbZGs87myceKlLEBYJkj35e0kLhrRN1M65Bav+eTfPIyAepawM01QLj1LN2kMi3pBh7fiN6EtJcYn2nIZB2yeJMhOo8aDHSqFE6uwIsDYll88pSNxPzXWfaPumAKyB9TwucbNTmASihWhvu8bhtrguABBtl/6cHjLvSEyHzfBYH0D1CLseXoNjBRNthD2eyyIPSH2gEGW+iB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeeaRpDQK4tqN5/ogMRi43cFZH0sgAJwvKKcOZosNiU=;
 b=Ubkg8nf2b/THZCY2NRo1Ji39SzTBkYwmXJyXhxqVn6R/cDAVn5G28B/jm/tz2Zrbtyi5fC2fJCykAZeOLkJPLSHIJwuo9MC0RsomNBjlCMWJRRxT2erzfHxWR4Zp7eZpIGYv7r2PokOwIimxFlnU0ywqYcpJrjeG/xTQU9NY7jaHdlCO8/gAwRLeUvxvVPSwpOU9K+2m6v4c3Mdf6lNoZi+MXE70SzfDdaBa4JdoLDSsqxwLHQQTuTYBzXkktxi+4fAlk/hITZ7WL5tQ81LM3r0q+DJfHsCZJBqEcW5F9XWANeHbYP5JLJ3yn9JNa/JaX8+XynyjVM8Epj+IkyQELA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 IA0PR01MB8240.prod.exchangelabs.com (2603:10b6:208:482::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Tue, 22 Aug 2023 13:49:20 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:49:20 +0000
Message-ID: <0454c839-5569-cbbe-f49a-c2f9ab09d65f@cornelisnetworks.com>
Date:   Tue, 22 Aug 2023 09:49:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH rdma-next] Revert "IB/isert: Fix incorrect release of
 isert connection"
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        target-devel@vger.kernel.org
References: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:36e::6) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|IA0PR01MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d38efb-ce75-4452-ecd1-08dba316960f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1Mr2uYcsB8rydIq8xrHA6G8ocf8Vv1gqWiHphVZZ0VCv0gm2ZvvebiApe9FTX5DpiCw4cnSgznisOFvwXJMlkxWuY3YQizBejTyIl0WBdhtB6I+01we5siPp1Bd1iyaHzIvxY0Nf5svubyAJt0zmbD5bKoTV5e6t09b+2zoER79VlseQl9abqOnr4f02y9mLa96kWdKy2cLlngxrnLC3LsRfpf2O+yfPGG82L5XHIah5m7mMVjMokjuY77jd0LyLrkIV5RFQ8vEP9G+tdPwyGJHArfDUNqdn4W8uG0SkL+3ik+gbyofM7T2RH6SgZjZttmRKn7qfLC525/758P5pkdHRI5SktyqXGR33b6o6zg3d4UNW5IOgy4pduoz7yLUi8DYIBg3ETVnsRDX3CmOC+wmcR08bug30u1nwhcnSDuqvbw89K3i0Pp35zMFwMasaHMu69CXLJ7GxYOHimWqfa+iycDf/0PT5UyVq0AKwr0/KV89BGeDMQjM2fZ7RWHvJbEKtp5CGBm1GMOpegMFGSPcNzNoJtPucdPGlM7jbNnvYT3F6QwD95uuZaXuAyxORLpH8EQtrHDZ39Uqng8U3uSoAwxAHEyL/mWst7+sYYQLqYBZfVUkLaNscjk7LunkFZ5ERemj0rf1GspLJxMY4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39840400004)(396003)(366004)(1800799009)(451199024)(186009)(966005)(2616005)(26005)(6512007)(53546011)(52116002)(6506007)(6486002)(45080400002)(83380400001)(8676002)(4326008)(44832011)(8936002)(5660300002)(2906002)(110136005)(478600001)(41300700001)(66476007)(66556008)(316002)(38350700002)(54906003)(38100700002)(66946007)(36756003)(86362001)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZKVzEzZVZWQnNlcGc3MWFUNVQ4VitBZ0JiTmFka1VoVFBSV3k1S0JXY2xU?=
 =?utf-8?B?R2xkOVdkd0d6ODlEQ0l3endNQUxORzJVOXErTWkvMzFTVHBsdFVzWWJPU25i?=
 =?utf-8?B?S1k3N2lZUEY4L1NlTkZjdEVWcEVuamRQbTN3MVBZZHlETGMycThOUzZxR29q?=
 =?utf-8?B?akdYOWtkY29ZQ0g4TnB0b0ZtaEZ1WDBLVURaWXVzOGdtcWc3MG40bTJGbXkr?=
 =?utf-8?B?OGlLMHVZWFlUZE50T0NIVXovMUk0RjMwSVNnOVErdnBEUzREdERPN3l2Q3ZZ?=
 =?utf-8?B?anArZ3N2Y1NPSmFHNWlBR2NwUjJDRCtDYUgrOUtUSHpNT2RadEVHRFk3QnBH?=
 =?utf-8?B?N09BMWhad2FuN01pNzdnL21vTm9ML3M0Z2NaanEvSE5UTzhMN3J6SHZWcGZK?=
 =?utf-8?B?aDE0UlFFTno3VUdULzZpR1AwYy9tNVJ3U3I0THNOV29keDZEM0xlcm5lOTFP?=
 =?utf-8?B?ckZscmdjSHJuNEd4ZWJsK1o5YjZWWngwOEhDTmt6YitmL2tnS1BYRmpxa1Q4?=
 =?utf-8?B?L3hkODdIOVpwS01KeW9SMVdIcGtRSmgrN0RxTmdNU2JHbWNVVWdxWGNidER5?=
 =?utf-8?B?QkVyMnVZWGZlNlNONjJmNmdpWlJ2TDlBZDN6S2x3NFlSTFdnZG5Gb0Vvc2U1?=
 =?utf-8?B?ZVd3QUJBSk5FQTR5T0Erd0NKcmNXSUwybDBlVE9mTWRQRG1zNDVxWEtDcnFa?=
 =?utf-8?B?eEwzSUorUmVZbzlUR2pJSGh5OVJHT2JNd2dHVTB5bndXNXF1RUhBVlRwdzVK?=
 =?utf-8?B?eGxSQVpIbTFJcHc5QmFWMUtrMXhNVEtvclE0MlFrcEo4T1NuZ1VGd2pVSnBn?=
 =?utf-8?B?ZDE3Q0twNVRiODkyVS8wTFVOM3AyUzE3U3NFTDlFQUJOTGIvL3R0QmtZa1Ns?=
 =?utf-8?B?OTFwZkFYZ1Ezd2tpamx3OHJsUm9hcXRUdEtaNUFIQVJkRVlDT2xGMVRIdk4x?=
 =?utf-8?B?VEo4aWV4VXRXaVlDcEJYSzMzZ1NMU1lnSFVNQUVJeXlNTWFHYVRTek1BQk1v?=
 =?utf-8?B?M01mWXp3VGVPSUdUNzBubUlwZ2xrWFhBcWY3dDdnOGVOQXpaZkNNVTBKREZO?=
 =?utf-8?B?dDZrOE1kaDhyVm1UU1pCd2Y2WDZZWmIwbnFiZklTZFIvSUdjdXBJYm9VSUlB?=
 =?utf-8?B?ZHcwc3RKd1QyYkhLQXdPUmpuVTY0c1Ztd3FMaWRkTTBMK1U5dHh5RXQ2ZE9J?=
 =?utf-8?B?dnpuWFdNSThGUDdjaERiV2RKdUFuV3B4Q0FRVkY1OTdQa2JZWUoxMnowZzBm?=
 =?utf-8?B?MzVCVHd0OTltK29URWdqdHEzRUt3MUsrWFZBNXhhZVRPd1VXV0kyRWJYSER1?=
 =?utf-8?B?akFzR2xmVldRcDMycUdUVFQ1UFN5UHBJVk5uaTE4OVdFcy9Nd3IvK1dRZkNJ?=
 =?utf-8?B?R09BUXltQURld0FDUS9IK0d5QjQweGkveUpleHZpaVRWMjdrTHN5UEF6RVlx?=
 =?utf-8?B?cHFINUJIcE9LbStyNVA3Z2QxbEt6RlJROWE5MC9MSXBaK1lrUFNzamRkWFZJ?=
 =?utf-8?B?WkJuNXBUZ1BaTW15RFIvUm1tSjRoQ05FSWlud1ZENUg5MWdHb3RBbG9rOWQ5?=
 =?utf-8?B?Qy90TTIxaUo5QWNuUGlLQ3R1c2JFVmkxUTd6Tll3Zk9TanRIckVoeWF6eENq?=
 =?utf-8?B?Ly9pNTlaRmJya0hiRkxYTzErOW5UNFpXUHNIMUpmR2NsTUFyeVYvSXgyaHdN?=
 =?utf-8?B?WllaWmJjN2gwS0gwRXEvZHVpSS80b1VqL0F5VUtaVG1YOXY5YzVCTUMxNFBM?=
 =?utf-8?B?Yjc4V2RzY1ZXamxkcE12Qko3Yk1tQnoxRmNiejJSQkdnOThHT3g5UUlOcTRs?=
 =?utf-8?B?dmZKWVlBYUErWURNMWRFUGxHR2k4YUhpRzI2MkxyNG5yOWg5TTlJWXJqaG9y?=
 =?utf-8?B?eVh3ZCtwQ2hXRUJ1NWlvVHFCOGxnRkxVRXc3dUFwS0dIRXdVcGxFVkg1NjdB?=
 =?utf-8?B?UWpwRytzcHVEZTh1WEdJbThvWk9mVmt3NDNWOHpaNzVpUHE3Yjd1RWtFSHVs?=
 =?utf-8?B?Y2lSRWdyR0cxYTlBWDJBTHlzYURtVVZxeEY2c2QzQkROSXVyeUlGektPNldH?=
 =?utf-8?B?b1JvZmRFT3ViakNIdWxoczdPR1pBRXBUbC9veWpRUmZNQkFSajhraWx6ZVE3?=
 =?utf-8?B?Q3hmbzJlVFp1QTdLYXlseWlYZ1VYS2pQVDZjUWU0aE1vM3lNbWdaWEcwRWFu?=
 =?utf-8?Q?+jo8hP6ICl0OE5RiWIpIawA=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d38efb-ce75-4452-ecd1-08dba316960f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:49:20.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31iF5bRCeU7BbpDMFgHXJRl5lOn2o/v8f20TkYyNJqLU6ZF0lfT9sMcHE9HI6f1b4lVdEq09b1oqWCYk6EU+nTy45EgeazAWwfG3WoNvg3bcdSVpwNkCGtlinqma7d66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8240
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 3:57 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> causing problems on OPA when DEVICE_REMOVAL is happening.
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 52 PID: 2117247 at drivers/infiniband/core/cq.c:359
> ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>  Modules linked in: nfsd nfs_acl target_core_user uio tcm_fc libfc
> scsi_transport_fc tcm_loop target_core_pscsi target_core_iblock target_core_file
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs
> rfkill rpcrdma rdma_ucm ib_srpt sunrpc ib_isert iscsi_target_mod target_core_mod
> opa_vnic ib_iser libiscsi ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm
> ib_cm hfi1(-) rdmavt ib_uverbs intel_rapl_msr intel_rapl_common sb_edac ib_core
> x86_pkg_temp_thermal intel_powerclamp coretemp i2c_i801 mxm_wmi rapl iTCO_wdt
> ipmi_si iTCO_vendor_support mei_me ipmi_devintf mei intel_cstate ioatdma
> intel_uncore i2c_smbus joydev pcspkr lpc_ich ipmi_msghandler acpi_power_meter
> acpi_pad xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg crct10dif_pclmul
> crc32_pclmul crc32c_intel drm_kms_helper drm_shmem_helper ahci libahci
> ghash_clmulni_intel igb drm libata dca i2c_algo_bit wmi fuse
>  CPU: 52 PID: 2117247 Comm: modprobe Not tainted 6.5.0-rc1+ #1
>  Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS
> SE5C610.86B.01.01.0014.121820151719 12/18/2015
>  RIP: 0010:ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>  Code: ff 48 8b 43 40 48 8d 7b 40 48 83 e8 40 4c 39 e7 75 b3 49 83
> c4 10 4d 39 fc 75 94 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b eb a1
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
>  RSP: 0018:ffffc10bea13fc80 EFLAGS: 00010206
>  RAX: 000000000000010c RBX: ffff9bf5c7e66c00 RCX: 000000008020001d
>  RDX: 000000008020001e RSI: fffff175221f9900 RDI: ffff9bf5c7e67640
>  RBP: ffff9bf5c7e67600 R08: ffff9bf5c7e64400 R09: 000000008020001d
>  R10: 0000000040000000 R11: 0000000000000000 R12: ffff9bee4b1e8a18
>  R13: dead000000000122 R14: dead000000000100 R15: ffff9bee4b1e8a38
>  FS:  00007ff1e6d38740(0000) GS:ffff9bfd9fb00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005652044ecc68 CR3: 0000000889b5c005 CR4: 00000000001706e0
>  Call Trace:
>   <TASK>
>   ? __warn+0x80/0x130
>   ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>   ? report_bug+0x195/0x1a0
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x14/0x70
>   ? asm_exc_invalid_op+0x16/0x20
>   ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>   disable_device+0x9d/0x160 [ib_core]
>   __ib_unregister_device+0x42/0xb0 [ib_core]
>   ib_unregister_device+0x22/0x30 [ib_core]
>   rvt_unregister_device+0x20/0x90 [rdmavt]
>   hfi1_unregister_ib_device+0x16/0xf0 [hfi1]
>   remove_one+0x55/0x1a0 [hfi1]
>   pci_device_remove+0x36/0xa0
>   device_release_driver_internal+0x193/0x200
>   driver_detach+0x44/0x90
>   bus_remove_driver+0x69/0xf0
>   pci_unregister_driver+0x2a/0xb0
>   hfi1_mod_cleanup+0xc/0x3c [hfi1]
>   __do_sys_delete_module.constprop.0+0x17a/0x2f0
>   ? exit_to_user_mode_prepare+0xc4/0xd0
>   ? syscall_trace_enter.constprop.0+0x126/0x1a0
>   do_syscall_64+0x5c/0x90
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x69/0x90
>   ? syscall_exit_work+0x103/0x130
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x69/0x90
>   ? exc_page_fault+0x65/0x150
>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>  RIP: 0033:0x7ff1e643f5ab
>  Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83 c8 ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0
> ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffec9103cc8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 00005615267fdc50 RCX: 00007ff1e643f5ab
>  RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005615267fdcb8
>  RBP: 00005615267fdc50 R08: 0000000000000000 R09: 0000000000000000
>  R10: 00007ff1e659eac0 R11: 0000000000000206 R12: 00005615267fdcb8
>  R13: 0000000000000000 R14: 00005615267fdcb8 R15: 00007ffec9105ff8
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> And...
> 
>  restrack: ------------[ cut here ]------------
>  infiniband hfi1_0: BUG: RESTRACK detected leak of resources
>  restrack: Kernel PD object allocated by ib_isert is not freed
>  restrack: Kernel CQ object allocated by ib_core is not freed
>  restrack: Kernel QP object allocated by rdma_cm is not freed
>  restrack: ------------[ cut here ]------------
> 
> Fixes: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection")
> Reported-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Closes: https://lore.kernel.org/all/921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 92e1e7587af8..00a7303c8cc6 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -2570,6 +2570,8 @@ static void isert_wait_conn(struct iscsit_conn *conn)
>  	isert_put_unsol_pending_cmds(conn);
>  	isert_wait4cmds(conn);
>  	isert_wait4logout(isert_conn);
> +
> +	queue_work(isert_release_wq, &isert_conn->release_work);
>  }
>  
>  static void isert_free_conn(struct iscsit_conn *conn)

Tested-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
