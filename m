Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8B3F2C36
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHTMim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 08:38:42 -0400
Received: from mail-dm6nam12on2094.outbound.protection.outlook.com ([40.107.243.94]:25953
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232694AbhHTMik (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 08:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuadRiv7otMmv3GKRxP0/GvqWYXX2vMOiKBVFGFX+tMNmwM50Z4m5pmkK0zxfXa/pv4Z3lX4DzlQB9sMESwZ23FKq6CXXwPzOu4XxB8RJw46eqiItYbBVpVFP67hiOIjvfF1QzCTjV9gl4H5N1VaXX/jceG+A8z0KFpdr8o59UWrNZtKohMimW7yzu/qWKG1wzPQW3df6OIXk2vPJ5VgctVP51povXbwDGvlbOt1VUhK9uKXqiWw+baqeB0/p5FaMm8V5g77gjMiklTT4y38Kug1kwNJpk0eXWCK/41pfg5X0U8EvwutqwdUkyvjuzjLvp7OsJyD8khzvgiaCGJimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5vk3Jfot00kedjx3zxf5CpfyVVL5XxEvy5VInvVkmo=;
 b=Nvn00ZRnYFtQOrqbvKmfMbQFf8LxRTnp7S+4A/ZjxA6xQtkNYhDrkt+wX34FpkqnYvDZJDuEslXTXeyXI1j64rQzlv3rny9DJnr63nGf1wWMzevbOgxfDXpXdbIn8+aBI68XOtM1WMTOvJiZdU3pPrvqEH31ZjMV6FliKdCVnO5wQZ3RMdfM04RfP1rRmY6DEpoIpdsqedD5QRIWhL3cpZSRS6FQ0oukx3d+4XK3RKtRF2nXGJrCgX0QCFMfmSnjcASvArdEIzD8Ra5Z51z+NRLFgAt1Vu1WXdlesA828VhHpIorCGVC2OE7eWMBY9uMD6L+7Ql7ZCNvdsvbwcvyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5vk3Jfot00kedjx3zxf5CpfyVVL5XxEvy5VInvVkmo=;
 b=N+ANEtZsFSenbw7hEIm+H+XX4IvaiT85J4yVX2CFt4Cdo44Cb545Jy/7WN1MzgjW8aXs93Z9xFU6iHfooceerGheKUyH5EEr+0F49PA8V4+JMf16zcU4i3uxU3HTUz0gb2OuduITixEKOohUTc3hTbrDRjrd+FxrEkVewCYXBVzq2WhfR9EqqLK/lf0pDTHRcvVKOfa81hp62Kpi7/T4Kl6hNepEqnWULSMcMVaBoCGAD7OdaUaC18f7AjpgO2MGLfk4Qidpmg9O9Np7/92ObSWWlJyZwZo2/2fY+a9rKmLrhz0NrWHA3RlrOjy8y4Cvozy111B1J23aNelN8LPDFA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6748.prod.exchangelabs.com (2603:10b6:510:76::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Fri, 20 Aug 2021 12:37:59 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 12:37:59 +0000
Subject: Re: [RFC] bulk zero copy transport
To:     Stefan Metzmacher <metze@samba.org>,
        Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Cc:     kaike.wan@intel.com,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
References: <04bdb0a7-4161-6ace-26d0-c3498327d28c@cornelisnetworks.com>
 <c40e7056-e903-623c-8413-67f5d63246e7@samba.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <0b24d051-e601-a471-847e-7763115c2a33@cornelisnetworks.com>
Date:   Fri, 20 Aug 2021 08:37:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <c40e7056-e903-623c-8413-67f5d63246e7@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:208:32d::28) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 12:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb9fd650-6711-458b-53c3-08d963d7577b
X-MS-TrafficTypeDiagnostic: PH0PR01MB6748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB674895162BF5906015DBC6ADF4C19@PH0PR01MB6748.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPi11IHeM7Xj1TAadsJttz6clsdOrSHshSjiRmFdtXG/pNovIRCs9GTq2i8/ly9yJ0V/Z/SoIoKZOIS5Ayv7yWBxuGyaBT/UGoq894CwH/B4kTNI4fd6XW+Kjsb3+SlUixzurU4kVr9hxSGggtkK36O5JHbAMo3AnKhN5iV1LDqLu1lxssk3b7yPLJoIEf6OOxwkra/8o1nRcfMxU7fvGWQHq4Fe/w7DAUmN9w7sHJocxrJA2AfbygNNcW+zjb3QusXGNI/xF/roO5g3X2fd58Vqr9bMlMMku7MIi6I+9IOZaBPUyymr4MBBpJIcx6FlGJdNS5ZjL5z7CwRjb6IsziYLUEfD3qPNAHyLHx3z8E2GM95g2rgjy1lPiBMMJPSYBcQ7vfSVsG4t6D/giJzhSmLcBsinnBCHeDnQh7ybuVUGt78Cwza/eIyvT907Z4VgAyCC7/erke4JOi9aG+Wkxh7vb3gFeR4DCPfBVMzR2NbCGsEn72jycghEK6k8EC4ldzprXUB9PnyidKaprKbPNM+a/f90YCqvczn0Lo+9zmhhO2/9B45CdaCC91sMcF7iyuaVjFCQSxBAVBavKIQ0mCNZ9P+ruYqSq+ni0nqRxl7k7nkizv9smkkkWJcTobqeqi7bdGtOKzHRJsTwYEo9YqT2QTeLsd+A5XY8gk3YRspjloNVR+xeP1BeElXDgxmq16VD6Y/Tjwgws8nNOxcWQcrzFNr0Ba8+yw24kLEEtdso90mjwHKmQz1rDAs9OeDfiNNpMFWcOEi5eN/E9f0hgdehihWRkyt1wcehhCWLITedeV1KaDZVvI5ia/PM1XC3Q1eZx8IYMOI32VUJ9TCBiuRCfsBSO2bjeiV7V30udVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(36756003)(83380400001)(110136005)(2906002)(956004)(53546011)(966005)(86362001)(5660300002)(66476007)(31696002)(2616005)(66556008)(8936002)(44832011)(6506007)(26005)(52116002)(38100700002)(107886003)(4326008)(66946007)(478600001)(31686004)(316002)(186003)(8676002)(6512007)(38350700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVKWkdmam9uRHFuclJGREdmR29QV0FDdU1SNDlFN3VGZjlmRGRGbFUxNkVU?=
 =?utf-8?B?SzFxOU5ZaXFMbk5ET1Y4cnFpcWRTdXlnYmxRMjNFeDdrVHd2ZithdSthUi9o?=
 =?utf-8?B?bldueFFqMWJBdGxmUm9qYUVXREc1blcrVkpOY3NzS2tqcGVIVVZxaVZrdXdR?=
 =?utf-8?B?Zk5wRW1DcDZUYmtGaG1Hb1FqMDc3RE1NcVlYT1F3b0loZVo1aEpyUzN5T3Y1?=
 =?utf-8?B?UUhTUXNHZHRaL01rektDUmRCdEtTdFJjcVVBQ3g5MDFDQ0RjbUFHNERTYXc3?=
 =?utf-8?B?UGNBdzBLQm5TbzI1cjBHcVUwei9oTlUvYk5Mc1dNc2YzZ0lRZ2l0eWZqdngv?=
 =?utf-8?B?dlFtczQ0NWVYL042OW1CU1FhR2o3Y0RTbVVoYXJWaEZvQUlNWjNjbVdRTm9u?=
 =?utf-8?B?WDhIbXdKY1E2Mko4c2hiMVJOVUtlWlkyaUlRWnlmS0NXRXlmYkhiT1VkRnU2?=
 =?utf-8?B?NlBHdFhWUzVJQ2hudWJ5Ymp3NjZYMjl4eTl0Y0htL255SFBOS1J4V2dFaXla?=
 =?utf-8?B?ZXpxd25jL3cyZi9iZEc2UVg5VG9pdTdhWmYxZW9GKzgycWN4UXlhanFHT2dG?=
 =?utf-8?B?WWVreFRrZ1Z3WlZ3MUlQdDJ4RkI0eFpubGhvWHFOdzVuaStvaVdMT2IzQ1lG?=
 =?utf-8?B?Q0NKMFBHUVBOVFByek5PbTc0U0Vid2RZb1JCc3VEOS9Wc2JSeU8zYzV5Q1lo?=
 =?utf-8?B?NExpVE0wZGVua2lGaUZ5ZVAwaS9WTnZpZFJvZmIzbGloSWdWd0VENmdoQktX?=
 =?utf-8?B?WklJRXRCYmtrRmloZGtUdnBVUXJPZk9DOEZ3ZTU5VkZKVURsMElFQzZITGRN?=
 =?utf-8?B?c0ZGNTVHbVhWSzd6ZUd6UzUyN2F4clBYTHlBMGZPek51QTJsRFhxOUR2dEMy?=
 =?utf-8?B?cjNrMkMwcnErRkpZdWphSVFJSHhpN0lBb0o0M0R4Ri8yUC9rdGdVVWNoOUU5?=
 =?utf-8?B?VFdNZWx2czVMbXY5VVBxeU5vU2tYR0RoRHBqK2R5VlhLTi9xU0pnOGhmZTEv?=
 =?utf-8?B?b1lBTDUzQ0Vjcm1xNFRKR3VZejRaSVlOOGNoLzRaSmkyQUVqK3NwQzIyVE5m?=
 =?utf-8?B?MjFLMzN2ckhLT0RkaGNwWE5IUTFXK0dKRGhYQVpHOFZUa094cldFU3Bycm5p?=
 =?utf-8?B?Z3QxdUhnK3FhaCtVYWVWb0V0Zms2ZS9vUFpOV1Q1V25PaGdJUmJ2QmVxcFJ6?=
 =?utf-8?B?Q1daNnRCRExlanVYWmdEamNMdzczUzJOZVAweFk1dnNrdUhHQkQySUVwdDh5?=
 =?utf-8?B?eDEvQzBJNHMyVXp0ai8yNDU5UWswaVpmZ3p1ektsMEdJK3JiZFpZRHNxWXRE?=
 =?utf-8?B?czJ2Nm1yQ0s4ZU1uVkNiZmtzSHY2a01tcUNYYzJYSzVja3ViQ3E5eEZIR3NO?=
 =?utf-8?B?WmpkWUlDV2FaT0ZxZXJkbmc2N2xzYVhxN1QwdG9ZRk9tSjVsR0hoZVNzQnYy?=
 =?utf-8?B?Q1p4amZ0dUFMVWhtOTZFU0ZYV3pjeEM1c0dBaUZsbjBOVlRJQ2RISkE0Y2cy?=
 =?utf-8?B?b1hXUjRQNCtETHRTZk5OZmhYM2dCbWhSbG1hWjlMcy84SDhGTkFrMlZueWVR?=
 =?utf-8?B?K0RIYUVzRERmOXhTd2k4TU0zVCtzNTljOWtodFBHMzM0b1dncVlxWnNiang1?=
 =?utf-8?B?TGVJWTBqZlJjWDgrWERqNDJwWG1pNzlWbDArU0JKc3VUSWJPcU9vb1gwL1Mz?=
 =?utf-8?B?eVVvZ1pJRmd1QnJ4cUcrWmlIN2NML3BtUVRDSGZtbVRlSGdTbS9aZHZ6ejJU?=
 =?utf-8?Q?OKVykhCxvPtaztTZJGGmuosSSQCxnDaEJ4YR0SV?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9fd650-6711-458b-53c3-08d963d7577b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 12:37:58.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvQmbp8NalXmAIYFdLOEGJS5Q3smR7yQe/oP/WY6As6D4wBC+fP+BICoRR/h2OVsyO9B8TWlA+OzqSbakLm2A8IrBWNg8P/zFCHXiSQf6r3NospvKFcGR8Y25MUGHs6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6748
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/20/21 4:18 AM, Stefan Metzmacher wrote:
> Hi Dennis,
> 
> just as a wild idea, would be an option to use the SMB-Direct [1] protocol defined here?
> 
> It basically provides a stream/packet like transport based on IB_WR_SEND[_WITH_INV]
> and in addition it allows direct memory transfers with IB_WR_RDMA_READ or IB_WR_RDMA_WRITE.
> 
> It's called SMB-Direct as it's currently used as a transport for the SMB3 protocol,
> but it could also be used as transport for other things.
> 
> Over the last years I've been working on a PF_SMBDIRECT socket driver [2]
> as a hobby project in order to support it for Samba. It's not yet production ready
> and has known memory leaks, but the basics already work. The api [3] is based on
> sendmsg/recvmsg with using MSG_OOB with msg->msg_control for direct memory transfers.
> I'll actually use it with IORING_OP_SENDMSG and IORING_OP_RECVMSG, which allow msg->msg_control
> starting 5.12 kernels.
> 
> metze
> 
> [1] https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMBD/%5bMS-SMBD%5d.pdf
> [2] https://git.samba.org/?p=metze/linux/smbdirect.git;a=summary
> [3] https://git.samba.org/?p=metze/linux/smbdirect.git;a=blob;f=smbdirect.h;hb=refs/heads/smbdirect-work-in-progress
> 

The problem with SMB-Direct is probably going to be the same as with things like
RDS in that there is extra overhead beyond what we are trying to achieve. I can
honestly say it's not something I've considered so I will definitely take some
time to read through the links you provided.

Thanks

-Denny
