Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE13F5063
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHWScK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 14:32:10 -0400
Received: from mail-dm3nam07on2109.outbound.protection.outlook.com ([40.107.95.109]:39841
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230316AbhHWScI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 14:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVyuX8mB0xN6AnWeVkdBDxsgPrLNlPa3dHEtgspD2ovZsUGJQmUQV8ePj9UPZky2dd8E/Gwr4VM8OtJT+7ZHMUDNabwQZg9kqYNhZlqdAjcLN/rpLK0qq76L0dUxZAqp9SEAG/txL3uQeECNk1hhHNFpQzykMInspcc6bcnuE7HnHEPt6SwouSrrbM49PPZh44Wbn+3JzQlJM9X11ck9Vz3xaIRr+VfZXkYwCbCKwdm0hPcv/XgLjep61wd156/GsMl03O78gUoFWLwso9inrqZUOgdtqa5Oxc8zqHsL6AAa/FmelBnRQgausHh31tGT6ErQfCELlYho9FnMeDYHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR9CMzEophVOuzhJNlE/tgA22SZeQM82SUb/2BS3HTk=;
 b=VjAvderfNEAac6tJqI0d6bvRurlcRMFIYcPSctM82W0P3LbIQYJDHAOjcFoan0vOwQKBqxS0OsaP7may16J23UmzYXq2lVLlw6DXB5QiAfLN0OnvKEgSBTDRyPvUIxffJ9dLmIUfTtxQA6KOsfnrsnSkkXZR4dHclWuNMpFJ2pAIiT0SOn2GzdoZkQKN/l+1Qf9YjqnoMcmjvQGkqmTfzlejarh8hC1vIoTmTyFnpLtI6zk70HCPw/1noLPQ/PlLGcv2t8GWOofKFvv0HPJdBNLMN/TZzUUHgBooz6goBlIC37S8g79oQl/yUYZCNe9jQ/xHjFuAE8A/3Mvz/TIomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR9CMzEophVOuzhJNlE/tgA22SZeQM82SUb/2BS3HTk=;
 b=iuvi4pXy6PtMib2HwotCMvqGpnAnvVw2IaYuk5BQs6CWrVM1g91fu3qfad8oHdMpdb5fZgpY8H+j8AX/FFMVnMbJkYhnJYcPhjuC05MaYlJi9PnFHmqyRw+BGZGZy0o4+npYpOu45n2u1QF1pqwIrI6sohDUhg6E0wRAXN5Son+/UOA6a80FBXF7XSsJoT1A7m/6mkbYtvkoeRmrj7hSrbGB9IeEBf+ktXdVJo+NLKz5hfG+++sTVGL1XmV+UqbDVqm4/mJW8GsmC87nOl/JyGqGR3iQ3Z8UFe8BhuGev6tvw6+YeD5WcHpTZhc4Pl9c1cMl30SoN7qg8XDX337HoQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6230.prod.exchangelabs.com (2603:10b6:510:12::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Mon, 23 Aug 2021 18:31:23 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 18:31:22 +0000
Subject: Re: [PATCH] RDMA/hfi1: Convert to SPDX identifier
To:     Cai Huoqing <caihuoqing@baidu.com>,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
References: <20210823042622.109-1-caihuoqing@baidu.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <a9122be9-82c5-30d3-e1b3-b9a1a07536d0@cornelisnetworks.com>
Date:   Mon, 23 Aug 2021 14:31:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210823042622.109-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:208:fc::20) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:208:fc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Mon, 23 Aug 2021 18:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc485d52-8a3a-44c8-8634-08d966643503
X-MS-TrafficTypeDiagnostic: PH0PR01MB6230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6230FE4A3C036453C9F1F700F4C49@PH0PR01MB6230.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y+3C52CaJ+uxO2bKQa7wkyR4N0YNenA7qJYgnX7mXpzvuJz5INvBcfK/Su9aNQHB9YgPWn1eql43yVYtKvUB60AeLkkOaIzscWwR5Qchlx5BWF8urK0VR0T5BXzNixqRCiT9vVznYEi7HrsZoeAlHJHgXnvClplrivfEEbvHY6w1KJ/Kc7KX38CHpvIaKWbovFHBJvOSG8cpD/iAc5WQLAfK1ILtnsuJT0RzU9R/zIfCSxZnp51XYRFWo0jv81g+HVv8IhTN7KFsRQ8xV3/6rfMmFodbRzGh4Nh7YbaD/oF7+Xp80HqQdwVjmxD2H2p0nOnZydL48z33/FSzTC/423CdUOsm5MS9rl2J6NLRzRnKl16KMhHr9Susw452QDP4gQ2Crnm6odLtR9RuTIVDLODBbJEnV29fl6jtrcLC8N6U89VNf1aKK5MZF8pxBUGCg7VD0EljSwOh7xZK3SoWCmdU4DokBDMfG7QHxnrwsiVh/0s6qWDoO7AZft04zJAuOIWPSw0nl6dsZffq3jlhux5gdtdCGlVDp7QTqUuoZpnxIJIbD4xC062Z78utSmdRdAR7gkFIeiXhAGFpSR7NDOthRd+KGOVzoHPKbYT8YZQT4YEFd7xpfnCpKS5FQjZldsolX3Oz/V9CtvyoKVDlG/XwcBtCZ22phNFe/dgKwG0RHcT2WrGNyFLUFWZzqb+VLyJ+Kangzce0YdZ6LX8+VgvOHzJdxTVerbgPsi710Cmbj9iCuSiNFlGat3H40Rc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39830400003)(2906002)(36756003)(2616005)(4326008)(956004)(186003)(31686004)(44832011)(478600001)(31696002)(316002)(6512007)(66556008)(38350700002)(38100700002)(83380400001)(6486002)(52116002)(26005)(6666004)(8936002)(8676002)(66476007)(66946007)(53546011)(6506007)(86362001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFhVHVGQ0k2ZEpySXVyMVFlNG43UWc3U1F6emNLZFVWWGcrMlV4amhYWVVH?=
 =?utf-8?B?VFZSa2llWlY5bUVDSU1xRGpwK1ZNOVJxZXlDN1ZIeEZoOWxmUExJWlFmS25D?=
 =?utf-8?B?RWpnRU9RVkptZXE5QmsxblBWb2d6TC9ic3hCTWNIODR6Wmh6YU1rK0s2Z2Jt?=
 =?utf-8?B?N081R2MzR3hXT2ZFa3N2TExBREpCTWhZbFRTRTBMKzFJY2VVZTc0WmdSNVdG?=
 =?utf-8?B?Mk5aNSszRXZodWI3OHNFdW1tbTFpNlMrQ3owblR4YWh0NUpwdE52NHpQNk5D?=
 =?utf-8?B?cDNEQmVOVmQzVnF5L3ZFTTRIMnVCcWlYYmJTVUlrUnZ5QUNyOGVOZ0prc2Ry?=
 =?utf-8?B?NXptNXR6dUV6dS9GelkzRzVrTUk2bnVtS25SNHFlbFUxM3ZQcVYrNnZDNVV6?=
 =?utf-8?B?ZDZNK1liYTdNMi9DQXZOd3BndUV1dUZSMGR1LzNwN1p5RjRZajFBWHZKMUNz?=
 =?utf-8?B?ZnJtblFwZHVjM1hkK1NoWlpTRngzZXpXTVJ4Q05Mb3R0TzV6c2ZrK2t4WVdE?=
 =?utf-8?B?ZjhjS0x3elhVeVk2Y2ROQU9xMEVaL0VNZjZqd0dYUXU3MGh5cXZrc2cyU3dv?=
 =?utf-8?B?ajZ3RXlIQkZkVEpweWQ3YUpmaVdDR3RwTHF1c0FXdzYxTGlOM0tEWldPeVlr?=
 =?utf-8?B?TUYxaFY3MDJaZ2l0R2tYTzBaMlcwLzdwMVV1RmNZSkhPOUl5cE5VU2ZRYWg3?=
 =?utf-8?B?ODhPdWd3RmFkSnV6M2I1eTVXSUwxc1FjMjRqM2dRNEJnVUFHQTlkTnJKS01i?=
 =?utf-8?B?RVJ4bXZ3TEQyL0lvVW1HUVFST210aEtMRlJhQ0tvZURaUUNMcmNVOGw0TTNU?=
 =?utf-8?B?RVJGU0tLTzdGN2Q0UnB1Vm9tL1Nwb2VvenpWNUNwVGZVL1BOUEQyUzc2a2tm?=
 =?utf-8?B?Q0h0eXpXSGZEOU5ONThHaFlzKzdDVElEdjJTdkhhTUo5Qi95YktQY3QrYlpL?=
 =?utf-8?B?NWQvNVl4RDFLb25VN3ZPRTVWVWNlbStKUXRTNitYYXc5WVE3QmRNT0xIL2Vq?=
 =?utf-8?B?VjZSMlFBL0FIMTBiSEx4NHZ0QlExTUZHT0hnVmtaVjVJUUxudGJUL2FDU0VF?=
 =?utf-8?B?Z0dTNXdJT0xmamcwa3BKU09ndEJYeEF3SEJzM2VsU1J3bTcwSzBrNHlHbDR2?=
 =?utf-8?B?RXRnbExYVlA1OEU5aGZzRWxyUkpXYXBGNnRlNlkzNEhIUWdCQWRZVmRZQVpB?=
 =?utf-8?B?RjhTZ2ExQ3ZHNXNuUFJmK2Y5cUU2dzRmNUNLdklDSENlSXd4NldISmdDdXgx?=
 =?utf-8?B?d3Fyb0t4bFVDTTF4dVlTOXdZb0hYRnJXcDM3UXhza1lJbm8yQnNYK2MxNnQv?=
 =?utf-8?B?QlpNNmFUMzdieDZJeVBQM3lmRkJ0dmt1anU1QmZyaThCZ3lLamdGa2NzVXp6?=
 =?utf-8?B?UnhTVWY2dFpGQjNtelJucUdQeGNzVVFpZzZ6dFUweVZpVU10cmhCMkp3SkVB?=
 =?utf-8?B?YStaTXdocTlDbWowb1pIU1ZFS2s3WGFDTlVMaTRSVVdLRy9jVk9EcVVUQmx3?=
 =?utf-8?B?cWZETkhNWER4Tm1aSUZCU1lUZWxXZHRYbGt1QmtPWjRmdnlzK1AyY0VjMHhN?=
 =?utf-8?B?QnhHYmlaQVBWSnF0RWczOGN5VUlxSHE4VzU0VGZEMDZ2N0R0MmlvdytSNkxu?=
 =?utf-8?B?YnJmcVVVR0dpeXJvbnQ1V1BXWVVvamlISDBzNGlYVUpTUGVxNTBUMG5ZSVUz?=
 =?utf-8?B?WmtrbEUvSi9EVThSMkRNNFB5US91Rm5iRUx0clI3NDEydmMrMzZhZjl4TDVa?=
 =?utf-8?Q?O1+5oP7XuAR6dLq+/mTDnPl28A+mKNEbkU7ZVmL?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc485d52-8a3a-44c8-8634-08d966643503
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 18:31:22.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy3IlN2Y56P0RNH01n7jhuREHBClkWgfd4uBfbPND6b6K3WqbfoBAFH0JdjeqnPsVm9U3G/wQVHyTbx1/+yHO2xyxg1SMwXRs1x4PXv9y31WCOPbdNgWgOPxHyOFgd4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6230
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/23/21 12:26 AM, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c       | 45 +------------------
>  drivers/infiniband/hw/hfi1/affinity.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/aspm.h           | 45 +------------------
>  drivers/infiniband/hw/hfi1/chip.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/chip.h           | 48 ++------------------
>  drivers/infiniband/hw/hfi1/chip_registers.h | 50 ++-------------------
>  drivers/infiniband/hw/hfi1/common.h         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/debugfs.c        | 45 +------------------
>  drivers/infiniband/hw/hfi1/debugfs.h        | 49 ++------------------
>  drivers/infiniband/hw/hfi1/device.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/device.h         | 49 ++------------------
>  drivers/infiniband/hw/hfi1/driver.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/efivar.c         | 44 +-----------------
>  drivers/infiniband/hw/hfi1/efivar.h         | 45 +------------------
>  drivers/infiniband/hw/hfi1/eprom.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/eprom.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/exp_rcv.c        | 44 +-----------------
>  drivers/infiniband/hw/hfi1/exp_rcv.h        | 48 ++------------------
>  drivers/infiniband/hw/hfi1/fault.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/fault.h          | 50 +++------------------
>  drivers/infiniband/hw/hfi1/file_ops.c       | 45 +------------------
>  drivers/infiniband/hw/hfi1/firmware.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/hfi.h            | 49 ++------------------
>  drivers/infiniband/hw/hfi1/init.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/intr.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/iowait.h         | 49 ++------------------
>  drivers/infiniband/hw/hfi1/mad.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/mad.h            | 45 +------------------
>  drivers/infiniband/hw/hfi1/mmu_rb.c         | 45 +------------------
>  drivers/infiniband/hw/hfi1/mmu_rb.h         | 45 +------------------
>  drivers/infiniband/hw/hfi1/msix.c           | 43 ------------------
>  drivers/infiniband/hw/hfi1/msix.h           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/opa_compat.h     | 48 ++------------------
>  drivers/infiniband/hw/hfi1/pcie.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/pio.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/pio.h            | 48 ++------------------
>  drivers/infiniband/hw/hfi1/pio_copy.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/platform.c       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/platform.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/qp.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/qp.h             | 48 ++------------------
>  drivers/infiniband/hw/hfi1/qsfp.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/qsfp.h           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/rc.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/ruc.c            | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sdma.c           | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sdma.h           | 49 ++------------------
>  drivers/infiniband/hw/hfi1/sdma_txreq.h     | 44 +-----------------
>  drivers/infiniband/hw/hfi1/sysfs.c          | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace.c          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/trace.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/trace_ctxts.h    | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_dbg.h      | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_ibhdrs.h   | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_misc.h     | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_mmu.h      | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_rc.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_rx.h       | 45 +------------------
>  drivers/infiniband/hw/hfi1/trace_tx.h       | 44 +-----------------
>  drivers/infiniband/hw/hfi1/uc.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/ud.c             | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c   | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_exp_rcv.h   | 49 ++------------------
>  drivers/infiniband/hw/hfi1/user_pages.c     | 44 +-----------------
>  drivers/infiniband/hw/hfi1/user_sdma.c      | 45 +------------------
>  drivers/infiniband/hw/hfi1/user_sdma.h      | 49 ++------------------
>  drivers/infiniband/hw/hfi1/verbs.c          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs.h          | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs_txreq.c    | 44 +-----------------
>  drivers/infiniband/hw/hfi1/verbs_txreq.h    | 44 +-----------------
>  drivers/infiniband/hw/hfi1/vnic.h           | 48 ++------------------
>  drivers/infiniband/hw/hfi1/vnic_main.c      | 44 +-----------------
>  drivers/infiniband/hw/hfi1/vnic_sdma.c      | 44 +-----------------
>  73 files changed, 133 insertions(+), 3170 deletions(-)

Never really seen the need for this large code churn. Is it really necessary?
Maybe it would be better to just touch this up the next time we actaully have to
patch a particular file.

-Denny
