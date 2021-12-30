Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF5482072
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 22:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbhL3Vml (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 16:42:41 -0500
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:43967
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242171AbhL3Vmk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 16:42:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYmXj6eiMTLsfZ4fngviIk3xXqyvnPWeTIOKV78G+eKEvEbge/a4fxUKRaa5KD/NOVPiOqShLXgol/w5OL23nHGT0FyG9a3Op5QeYewwJrjcWnO0SMNegRb8LRBrtTFcyMeaf5cVfbn+BL+s9iNPRNYnrR6AFNK0KSMR1NfiI/xkpsYuZ/dWff3jALTVnKQr2+S9SeVFvWqf3abmQXkHcPNO1ERgl8y4QNzi8znkxSE399ZdwDtOqoaxJoBP4rAxgFK2rkGvV4th5IYCQFkj3ffL1cgSgVXAbHLo2j6IHyePtsBzVhijpoGzeX9/3EUjehkUd3Vz47IQ/6KaSHOQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Nhg3K43xAe3P5SXD2K3B7PBVXysbPIGt//7+viC90=;
 b=PaLfyKCvCMaIQM1AgDPUvVxbWItcbiZdWpahH6NiVKO2mNvZn44N+pya8grd1DHWdgwI6U6w8LoUFng9H7TPifXkc7EQSPm8k95m49P78BAJjXeTzzT42HoOYcz3iV7ep0q3DeiX18kXbsG/0CZqfiKoORgZcsOqq8r9+2fmSorUUz6ZSJb5tq92Pw67xPWL2Srr994QcuDbjBhHyz01qCKtL6AUdqZ4rB+HW7vCha2v5oADIga4MpcMxEe2TSO0yOcUsHyrPvu2qtwAg2NmVLkPf6IyXk3ZVlv01OmygCR1edmw+7x2JaCxrY9i55WnxfxSGqi6xB9qG7zC8dfFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 MN2PR01MB5887.prod.exchangelabs.com (2603:10b6:208:193::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Thu, 30 Dec 2021 21:42:37 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 21:42:37 +0000
Message-ID: <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
Date:   Thu, 30 Dec 2021 16:42:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0037.namprd19.prod.outlook.com
 (2603:10b6:208:19b::14) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ddb55fe-5ff0-4ef9-97fb-08d9cbdd4c09
X-MS-TrafficTypeDiagnostic: MN2PR01MB5887:EE_
X-Microsoft-Antispam-PRVS: <MN2PR01MB588760EB37F4F3B90ECF84EAD6459@MN2PR01MB5887.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pq4XrAhFoJ23rO9I5ZYbZ/RAzDbFuLAoXw/TuC1356nUOsVb5QH9+hNy2oPaTDrjpJcf6IcEyJ7zbqRfhwtQjfLwjTqmIuOy9pzmf1sJr+ufqsf9frrSbCm/e/nMvnwag8zMRsaKfmS3nrmcX9r8bPKRNVYq7/THNhEm78NphEZL9SwedfnrXmjtyuf7gOoyEt9XEuDtvU83mmenKFe/oMCi1a5e064jYbeV4bKbjwXmO5NH7++bIRRHMgC5vPJBZ9e+QuS0QptGod8YTNcZPaVf1zV1YMkqH5VR9WpJKED5OGeR/dI6Ox6iQZ1x3ZmEBDUSsSYBh5XElJpeQdXq8O3IQY5jyj0PsDz/lpEmIs6HoI7XZvoL00cyuYZL8itdzkJVHKIxhKAsmbxBbJr5p8ZqWTDRC18/vOHu1GA1dCcQOkKo6r6nvltla4FOoTkB9kQID9Q++2XjKBeM0PTxt/4vpbEYqe+RTHUZu46ypR9P7InSbvs4pTxkp/Fw6ZCiUK8BBwkyDd/B4YEdD6jIrGkiiAKk+qjLN0FxBjUPeFodMLCKeNMM2saqOD6LCiurzm3aAtmudN//dpf+ibFxVODsmyMR3sV35x87s9SM/x9fnpRn6+YeNg5vwztx4kktXjUFqZp5zGk/8wvWu7xKa7w3ZFf3yI5WOCeMgnMT+mZoxJI4jYLv5IkczAjbIuZ0uJDv853Z0E9QlzHclXwN3pdbxbZfWoZxZRE+e5cqKK9eSSKiFv/RScSYvKODinUvhGL8nv1+ZlGSxFE364yrvKWPgRvaBe1xSKggAAK82ddLZOOwsAh8GAeZoFb/aM7H36zRpvHXGTEYCiG/t7/bVDcF7/tLBKguMKQz3btxDkJbcSO9QTmfsV9rLEd6D4Hy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(366004)(396003)(346002)(66476007)(2616005)(2906002)(6512007)(66556008)(5660300002)(508600001)(31696002)(31686004)(8936002)(86362001)(66946007)(4326008)(83380400001)(6486002)(966005)(53546011)(8676002)(6506007)(52116002)(26005)(316002)(186003)(110136005)(36756003)(54906003)(38100700002)(38350700002)(43740500002)(15398625002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFE5aVFQOGxxZ2dGUVJGR2Q5Z3J3LzlCYUd2NUhFMWJJRTBLT1RxdEkxeWpQ?=
 =?utf-8?B?dUFIQmgxSXJFRXp3NFJDUlJJck9sZnV6UW5laWQ0MzlmNHJ6SHI1TjloaGVS?=
 =?utf-8?B?M3dKSFRWRGE0d1ptYzBWUm1oZ2NYK0NWSTBvMHBobHlkVkg4L1owMnUyZ1Zp?=
 =?utf-8?B?ZmQyc0RZZDBWdkxNWW9KU3NmUW45L3dhOUtPL0RkWm1yYVQrcWRWNXZqOExt?=
 =?utf-8?B?RjNiN3ZZdkZwd1JIbUJwUDY4OGJOdHZRa1lNL1hUZXA4SHkrc1E4SktvWHNT?=
 =?utf-8?B?Q0Z4N2tqK01VWDRBMHlCNzZxQm9Lb1VmQlBxVFhjNERkQysyTmFNVnF3TGdp?=
 =?utf-8?B?cG9WT3Y5L29OdURqQ1NhY2hmbStaaTY1VmR6N0xlTUU4NFl0OGI2cHg0M1dM?=
 =?utf-8?B?dzJPNGtIa0pUUGdWdUg1WU00d3dlb0IrZXFWT1NhNmRZWS9IRHlXbW9qeGtR?=
 =?utf-8?B?VktaK2htWnFoRWpFbTRvMm5qNTNJNGwyMVI3M3UwSHorQjgvMCtyYWFBSmxn?=
 =?utf-8?B?WTFicGxrTkg0NkFRL01iTnhGUDMvdE5wR1J1aWQ4WFlmUDg3dEdWN3NhSm1z?=
 =?utf-8?B?NUUyaWtEV3lBcm1uWUI5Y0pRYkh2QXlNU3VkTzVLUmpBTEd0eDNxbVpYNXpL?=
 =?utf-8?B?QUQwVkxzR2VpSjFoSk41VGlndHdiQ1htRWJieXNjY3o5VHlKQzcyOEpQV3NJ?=
 =?utf-8?B?QXNSdnBXRzBzWnlnZ3ptOS9SV2R3YU9WOHRQTkRRSjNITzJsR2h1d3lIbGxP?=
 =?utf-8?B?WTdtUkpNUEdLbzVEMWxlbmUwOVVhQlM5SWNNb01wYnVLYUpiRWRqamdvbDBU?=
 =?utf-8?B?c1UvUnI1WXhuYTlwcVNnM2hzQ0JscWNqUnlCbktmYTdzY2wvWlJDVkRBTlNi?=
 =?utf-8?B?OWZrbzVjeHdPTEhlcXBhdDRZZEZTbko4NVJqdFU5aTM0cUkxTjl4VFo0WmdB?=
 =?utf-8?B?Sk83R0t5MXJvZVljcGpDclBwMDFzMVUxc3hubHNkbU1NMnVqaEp2azFvdHV2?=
 =?utf-8?B?Z1puOFNBTG92dmJuYnpnYkZGN1lVYjhTbkY3S2p2MTdmUnVCN1h6eWRIVHds?=
 =?utf-8?B?U0RhUDl5WEdpOU53dkZwUjJFR3JHWk0rSTZIVEJibkd4dXBOSEVwdmI0ZElO?=
 =?utf-8?B?aDBUM1NzUkNFVXE3VnhIWExIQ0tmZFBJRmlLTVhIL0FwOHFOblEvOGhpN3BE?=
 =?utf-8?B?QktlSEtwckNxa1VlcEdEczdIRnRkZkF2empNN3hoQlA2NHlQQVNkVnBaRnNz?=
 =?utf-8?B?SmYrWGRlMjZvQU5jMUhmWHdpVXNxUit0MnI2QjBtQlhrcFUveUNkVXAxMWxi?=
 =?utf-8?B?R0IzcU82QXRQZ213aldlMWM2OHM2bUtBaXREaUg1MFRibit3MzRGVURCUHls?=
 =?utf-8?B?Sm1xVERHMWUzMWsvL0l6SW5FNkVyV2djWUp1eThxN1FNRmF2L09OQXlYNHNK?=
 =?utf-8?B?bzMwa3prWFQvc0tjMkRwWGROaVJpTWlBN3g2ZUgwck50OFpUcnBDbWJtTHRr?=
 =?utf-8?B?d1RDTG55K0pwaURMZHlSUXhYTnU5cFpFRDJNdFZrTi9sY1BjZFlTKy9sRnVk?=
 =?utf-8?B?b1gydms3MlVpUVlVY2hvSWxqZFBRS1VvYUF1cnZNaHVuUnJZZlJSSm9TN2Nt?=
 =?utf-8?B?UktCVGtYbUZlZnRaYUFET3o2MDRvenJJL3oyR0tGNTZRWnEwY3NqQ3hLdHBa?=
 =?utf-8?B?Sko2RjliTVFMcnIwb3pSVHhSOVVJY0JWL2xESkhFa3lPYk56TUJoYUVlSmEr?=
 =?utf-8?B?Zkw0YnJ5c0lOOXJmTHNFVG5EWjhoYkE2NzJpRnJ6UWVTZnF2bjkwV0xIZ1pl?=
 =?utf-8?B?MUhwTDQ4SHVHdkdzdU9mQWJaN3BrS1F2NzlXQUp5MGthOGdkUnloNVByOEJH?=
 =?utf-8?B?aWxWNjJhc2luVEc4b29jZEZRSk0vOENpYnovcVJZb2JrcWFTdHNvQ29ibkMx?=
 =?utf-8?B?RGJ4TUd3R3l5dnZOU1Z1eUdmbDl6dVFNcXJwZzdQLzlPS0hIR3AzM3Y5ZUlr?=
 =?utf-8?B?eE9zL2I2YmVZQ2F2OVV4d0NqZVczaTBESEFTRGppKzNscTlIV2JLT0txWHJk?=
 =?utf-8?B?L25jSStzVjNIUVc5cFZiUS9UK1FuemVYZGg5ekVaYWlwb3JiU2R1VDVUekNO?=
 =?utf-8?Q?6Ze8=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddb55fe-5ff0-4ef9-97fb-08d9cbdd4c09
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 21:42:37.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xznxMqZPqHGp/w2PMPXjXJHqaURofqAtwbvo3yo1jdm4N8vY1fOE3A25l57HF737
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5887
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/30/2021 2:21 PM, Gromadzki, Tomasz wrote:
> 1)
>> rdma_post_atomic_writev(struct rdma_cm_id *id, void *context, struct ibv_sge *sgl,
>> 			int nsge, int flags, uint64_t remote_addr, uint32_t rkey)
> 
> Do we need this API at all?
> Other atomic operations (compare_swap/add) do not use struct ibv_sge at all but have a dedicated place in
> struct ib_send_wr {
> ...
> 		struct {
> 			uint64_t	remote_addr;
> 			uint64_t	compare_add;
> 			uint64_t	swap;
> 			uint32_t	rkey;
> 		} atomic;
> ...
> }
> 
> Would it be better to reuse (extend) any existing field?
> i.e.
> 		struct {
> 			uint64_t	remote_addr;
> 			uint64_t	compare_add;
> 			uint64_t	swap_write;
> 			uint32_t	rkey;
> 		} atomic;

Agreed. Passing the data to be written as an SGE is unnatural
since it is always exactly 64 bits. Tweaking the existing atomic
parameter block as Tomasz suggests is the best approach.

Tom.

> Thanks
> Tomasz
> 
>> -----Original Message-----
>> From: Xiao Yang <yangx.jy@fujitsu.com>
>> Sent: Thursday, December 30, 2021 1:14 PM
>> To: linux-rdma@vger.kernel.org
>> Cc: yanjun.zhu@linux.dev; rpearsonhpe@gmail.com; jgg@nvidia.com; y-
>> goto@fujitsu.com; lizhijian@fujitsu.com; Gromadzki, Tomasz
>> <tomasz.gromadzki@intel.com>; Xiao Yang <yangx.jy@fujitsu.com>
>> Subject: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
>>
>> The IB SPEC v1.5[1][2] added new RDMA operations (Atomic Write and
>> Flush).
>> This patchset makes SoftRoCE support new RDMA Atomic Write on RC
>> service.
>>
>> I added RDMA Atomic Write API and a rdma_atomic_write example on my
>> rdma-core repository[3].  You can verify the patchset by building and running
>> the rdma_atomic_write example.
>> server:
>> $ ./rdma_atomic_write_server -s [server_address] -p [port_number]
>> client:
>> $ ./rdma_atomic_write_client -s [server_address] -p [port_number]
>>
>> [1]: https://www.infinibandta.org/ibta-specification/ # login required
>> [2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-
>> Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
>> [3]: https://github.com/yangx-jy/rdma-core
>>
>> BTW: This patchset also needs the following fix.
>> https://www.spinics.net/lists/linux-rdma/msg107838.html
>>
>> Xiao Yang (2):
>>    RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
>>      resp_res
>>    RDMA/rxe: Add RDMA Atomic Write operation
>>
>>   drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
>>   drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++
>> drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>>   drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
>>   drivers/infiniband/sw/rxe/rxe_req.c    | 10 +++--
>>   drivers/infiniband/sw/rxe/rxe_resp.c   | 59 ++++++++++++++++++++------
>>   drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
>>   include/rdma/ib_pack.h                 |  2 +
>>   include/rdma/ib_verbs.h                |  2 +
>>   include/uapi/rdma/ib_user_verbs.h      |  2 +
>>   10 files changed, 88 insertions(+), 19 deletions(-)
>>
>> --
>> 2.23.0
>>
>>
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
> 
