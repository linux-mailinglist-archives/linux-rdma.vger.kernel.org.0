Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E652B481427
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Dec 2021 15:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbhL2OfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Dec 2021 09:35:09 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:25921
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236856AbhL2OfI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Dec 2021 09:35:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8rKJjQN9fO0AqGTpn/T5BFNs/X6+9vzF/fcl/1zeLeJgmE4tOHT40OI12kUwcvG852AMo90XUwHz+Akunomvlni4keLyG7GOzIfF7eR4xKwX8McdmM4rbwmRhmYfPnofghL/quGvRVFVU0nnKRd01Shl17Vdah3JLVXN9SZNYhIOvqy20ij9X0d09iPydrjsoSg3tanYG8SCWFa5MyNYVAu/de/Jzwvk9E1LgMm9CZ53DfjGQZxFZnRH9qYFRFBNtdlBHZ5gQgTuBQ5K0+/ix7xLwEDiI8sXkRdVXvtHSP36cJI3sBbu0uqpt1OEJEMPQz8cz8gKwP3IgLYJcSbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRPa3a4pMZ54xN4th0m5srsnZUcHNCWMex2t5sW94Aw=;
 b=LQUCPNI50B3dNx8Iq/Z3lRYOsVJZ4C9FSU4ROHvn57OGctdRlMXaU3Zx4D/2BeE8gQ8UXnuz8JPl4MZyfcke8WAUTqST9f2mJX2bpYLbe4dn7sZA3c9xq2ZuwUIPMnsR5mLCL/VIZ0tm1NU1pcvPcG6LLPY+fZtSfloKLASKsUvqn35z03e4tTcuU0ETc+fVZKRxXrTLvonZqUH3R5bmh0StZliOYU58SJVS/OEVH/os4Rwp7W8jlIkWHQv6KFHwRtVx3POM5Gw1AxNPkO9I7jXI2PzYLeqImO74JI/gUXuwUIRQOgi1Lfo6P78PcQHaSRZUv7Jb7GqenrZxxhQacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BY5PR01MB5937.prod.exchangelabs.com (2603:10b6:a03:1c9::14) by
 BYAPR01MB4536.prod.exchangelabs.com (2603:10b6:a03:a4::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Wed, 29 Dec 2021 14:35:07 +0000
Received: from BY5PR01MB5937.prod.exchangelabs.com ([fe80::85:5f63:c76:b6e2])
 by BY5PR01MB5937.prod.exchangelabs.com ([fe80::85:5f63:c76:b6e2%3]) with mapi
 id 15.20.4844.014; Wed, 29 Dec 2021 14:35:07 +0000
Message-ID: <5b00b84e-bced-e4b8-70c3-5951dce2598e@talpey.com>
Date:   Wed, 29 Dec 2021 09:35:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 00/10] RDMA/rxe: Add RDMA FLUSH operation
Content-Language: en-US
To:     "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liweihang@huawei.com" <liweihang@huawei.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@cn.fujitsu.com" <yangx.jy@cn.fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <BN6PR11MB00170D6BE0A19A48239FE1E895449@BN6PR11MB0017.namprd11.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <BN6PR11MB00170D6BE0A19A48239FE1E895449@BN6PR11MB0017.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:208:15e::21) To BY5PR01MB5937.prod.exchangelabs.com
 (2603:10b6:a03:1c9::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae5bb47-dde6-4bfd-96e1-08d9cad86891
X-MS-TrafficTypeDiagnostic: BYAPR01MB4536:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB45365EF972270D6711929194D6449@BYAPR01MB4536.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ptNqTJEmSDakEt2gQ9umX2w2Ss9Pm7fing6jFFPXjjIqgidaRi54mhq5bm5ip5vJFLhPD7Ok7gB38Q8oCjlEQgZ6/2vO0KFYyjLCpPtbdOk+iONE7KTPhLMM+go0zIUdgUGAI4RODId0aYWTL2gIw8vwyFDeheF7Pxp/QxAdEVOPiZgHGmDElRBIqiPZzknu70LTL5zmh+BICuem9APnCOp2lHoIDczEXQ3fe6SniIsRIzWKrNkNwvVErEIhQqSuiI2ks2++k0KXo+45kJA9ngs71RD8moV48kzTP527/dGaUAnJPuYQYSPAfny5QwTioXfskaOv9G27gEXZf4mvOL9EKe2a4/Kauy/3LX7SUzk8LOhzVY47cc5dRsEUA0Y3d8U9zL8MtwzbI7O0YXh/Y7tauialjdJ2+6nlE37ta2mdKWkSogPtBmtuQGcxKcMRDLi24J+PSy8DTNoNwzdYKSnolLC85S11G/dW9pOEKfLek134hA4WtpQuH5cx4xtAgZ4j7iE2ijOrxWuZcibgq8oyBV2eV8UJy7tyEnwlOr9ZvT/Cel2hy4q4DwrT3TBl7jWEMMCeJFu5uuVCZaihoDV30zr26DxPuGXYZ9XOOZ7JjFDmmP6hRmTG23lhwil7ppaQQK9IPxzd3562EFHPi1xj8E1nsCxWo1C+IMTEC9RWjQRO9ojkBPrmQ+sMjAUk16b12WpPZ3f5qO5J2XwMBMPbkIFRFUw/x8ZuGE4Jqkmk+bcddDzJRmQYzwJemDP44BG+YAuTvUc2uWOUT8XP3xmywxrNxI6bMp6HsUgjt7WB1E/8u9p/iut196+eTat8u2bkRWs/g0UyrmwXWRmuo80SSwi7wt5Iu/SmuqkTwCiszmipbZTqAQe9WstUqzIPw/LHGnMp25Qhwkxu68kIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5937.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(396003)(136003)(346002)(186003)(6486002)(2616005)(31696002)(110136005)(8936002)(54906003)(5660300002)(316002)(31686004)(508600001)(6666004)(2906002)(6512007)(66946007)(8676002)(7416002)(66556008)(38350700002)(83380400001)(53546011)(52116002)(26005)(6506007)(4326008)(966005)(36756003)(86362001)(38100700002)(66476007)(21314003)(15398625002)(43740500002)(43620500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlQwTThmMEM2M2dURngrOFU3V2w5YmdKaVZvbzJJMmVWY1lqQXVHbVVlV0o3?=
 =?utf-8?B?cHFEVnozR1RocG44SGRNTnN6Q29mQ1ZoY2FZb1ExVTZlVE9IYnBpVkxaMElr?=
 =?utf-8?B?QndIWWZLY00xekcwcGxzZWl2L094d3pNRDV4UDJ0TTRTZEgxOE5kUE1NalBP?=
 =?utf-8?B?aTE2TEFiWmRmazZ3L2dFWFIzT1QzSnBST2l1dHZ4YU1lM1hCWnI5dGtlUERN?=
 =?utf-8?B?dUh0bGt1b2xpSk1SaUdOeEJSMnFaSG9CckZFQ0hYOWhjRzNxbnNKMlVRYks2?=
 =?utf-8?B?UXpVNC9oYlZsTnFSdzdQTTFFdmNHWFc1bjBRbE8yd2prcmlVR2lrTXZRWHhR?=
 =?utf-8?B?L2ZwZU00MGNQajJSOEJXdWRNUzR3eGNDd2xuMGxFVHVlZWM2TTYzV0VZNWRE?=
 =?utf-8?B?NTFYbGt6UXpST0RaN1VCTkRZcTVXTlR1cVErZWFHTjY4M3pycDlFUVpWYXZ2?=
 =?utf-8?B?S3hZckorSE51eTVOVHhIK3lZeHk3VmlEM2R1WStXeFNNYmdrL3BxUHpXbTJy?=
 =?utf-8?B?dlBoS2JHMHZDZVBQVGNNazFFSjNuQXVmS3o0ZmJSaXNRNkxoQkNReVFIQTRV?=
 =?utf-8?B?eUI1Nnc5eG01TXVDaGU4QlhQcEhvbzFxcGloMVErbG9ieEJ4aFhrRHdTeStY?=
 =?utf-8?B?Mjd2L1FUK1RpazJoWWEvQU15N3lrdm9Qc21YUVZjOGFqT0RhVElVb0JwYVdZ?=
 =?utf-8?B?RERHYU5DakZYNnhUclVvdXdpaklOdjFhdUxHUlJZbGhkS1hWTENhQjYrWGo1?=
 =?utf-8?B?emdHT011dnBVVjRHYVBTdWdsbkZOM3FuRjR4T3FnK0Q1M3k1aGtZV3VVbWw5?=
 =?utf-8?B?eW1VbzBRMU9sd2hSUGJrekd1aFdtWExsY085U1RTVDd3T1pYVnZzMHp0MUt0?=
 =?utf-8?B?V1hYMW1HWGdWbkZZcDR4d2xBbEtyenlTaDI3bzZDK2tEVDFwVHhzRlY0cThI?=
 =?utf-8?B?TzJOWDFsQlpxNmFUZHRtU2FXRHUvVlE0bVdPdElaNkUzVGl1akJ5V0V4YWhH?=
 =?utf-8?B?YmZTb3FOaXlHK29RaWt6Szl4OXFPUEJxWlduSk1wbFRWSnlQU2FLYmpiVFZo?=
 =?utf-8?B?bXhxMmtTM3lvZkdGZE5KNHM3Sk5EM2hTOXFBRXNkd2xaS1RKUlpHZ1paWlp6?=
 =?utf-8?B?b2VGYVpIYUkxcGNZNnlSQWZXdXkwZlQ5K1E3Z0FZQjMzRmNSNnd4VS9pQU1x?=
 =?utf-8?B?MkNLRzB3QXZGaDNudTFmdzd2ZkZjaFRUWmZoUXE2cTVKNWVXUGdQalF2S2Ja?=
 =?utf-8?B?T0J4bFZqa2tjelg4WldRaHhQcHloQmFPdEhlQTZyMVRtU2FZclhKUDJEWjJx?=
 =?utf-8?B?L2NQZk1sYmllTThnMTBDeEYzdlh6NVFJWFZSYkduM2tsNFBQVVREeEJlWFZj?=
 =?utf-8?B?ZzQxc2lQOXdlSnoyMnMwdnBEa3dYT0xIc1ZPcm1lNmRFalVsOGVxaHFJd1lT?=
 =?utf-8?B?em9XMnJQcExaK2huR0xHT25uSi9VN1FzdCsvOGdGb3hXT3ZtSG53MXhzTGFj?=
 =?utf-8?B?UDBHczZmZzZrQnRTaWhGNDAwUnh4eGJ4WXJtNzYwOUFiNXZJNGgydnBPNkoy?=
 =?utf-8?B?V3FBNGkwRlV2NWYxSG5Jd3p3RTlxZ25xcXhNeDRBQWxaQ2hwOWFXeEtha1pX?=
 =?utf-8?B?RGI2RURlaHNaME1GRTFXU2hhT0tJbWJUS3pZTmZ2SGh0WUhVaVJDZlJzZ2VG?=
 =?utf-8?B?QTdtRFQzVzg0NGtvNWIzazVWQkxFRkFtN3UyVytCUkhmRmNsTG9QN2REbm9Z?=
 =?utf-8?B?aWFJTTQ2Umd4WlQzVDF5eThzSEN3MnNNekdOWDhvMW9DekE0QkNOK1gzWnc4?=
 =?utf-8?B?bHNrTG1yOGpSWUNEUFVWMUtycnhMd052VnJ5NUN1eFBlaUtnZjBzWUZzUUFo?=
 =?utf-8?B?TmJXMngxWFNhYWZqSFY0cTUrSFN0YUVnSHBsSTlmVGZrYzZ3VEE1RE04RzFu?=
 =?utf-8?B?dWxZZ0dXbWl1QTRNTWVITWxNbWlSTTBNY01SYWFTZHB2Mk1WM04wMG5mZnA4?=
 =?utf-8?B?MDZKTFB5NS9NOStpSWd6WjB1ZTdKRWxyRFE2OWtlT2dOZ2VEUnlRSmROcjZF?=
 =?utf-8?B?bW9JSlFWZzlzSzlqWkNpa09iaDQrd1lJblFXdDRsV3pIU09XRkZ1QlRBcUxK?=
 =?utf-8?Q?e8lU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae5bb47-dde6-4bfd-96e1-08d9cad86891
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB5937.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 14:35:06.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKxAoTNw+qAWmNCuvfbNQSOx74E2DLtXHljcH3C5UcZnCZVrnUlnavO5wd+GPgVo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4536
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/29/2021 3:49 AM, Gromadzki, Tomasz wrote:
> 1)
>> rdma_post_flush(struct rdma_cm_id *id, void *context, struct ibv_sge *sgl,
>> 		int nsge, int flags, uint32_t type, uint32_t level,
>> 		uint64_t remote_addr, uint32_t rkey)
> Shall we not use struct ibv_sge *sgl in this API call but explicitly use flush length (DMALen) argument?
> It will be similar to other rdma_post_XXX API calls where ibv_sge is not used at all.
> Ibv_sge is used only in rdma_post_XXXv API calls.

I agree. The Flush operation does not access any local memory and
therefore an SGE is inappropriate. Better to pass the actual
Flush parameters, i.e. add the length. See next comment.

> 2)
>> struct ibv_send_wr {
>> ...
>> 	union {
>> 		struct {
>> 			uint64_t	remote_addr;
>> 			uint32_t	rkey;
>> 			uint32_t	type;
>> 			uint32_t	level;
>> 		} flush;
> 
> Shall we extend this structure with
> uint32_t length

Also agree. The remote length of the subregion to be flushed is
a required parameter and should be passed here.

Is it really necessary to promote the type and level to full 32-bit
fields in the API? In the protocol, these are just 4 bits and 2 bits,
respectively, and are packed together into a singe 32-bit FETH field.

Tom.

> and abandon using *sg_list as it is related in RDMA verbs to local memory access only:
> 
> Ibv_post_send.3:
> struct ibv_sge         *sg_list;                /* Pointer to the s/g array */
> int                     num_sge;                /* Size of the s/g array */
> 
> In the case of flush, there is no local context at all.
> 
> Thanks
> Tomasz
> 
>> -----Original Message-----
>> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Sent: Tuesday, December 28, 2021 9:07 AM
>> To: linux-rdma@vger.kernel.org; zyjzyj2000@gmail.com; jgg@ziepe.ca;
>> aharonl@nvidia.com; leon@kernel.org
>> Cc: linux-kernel@vger.kernel.org; mbloch@nvidia.com;
>> liweihang@huawei.com; liangwenpeng@huawei.com;
>> yangx.jy@cn.fujitsu.com; rpearsonhpe@gmail.com; y-goto@fujitsu.com; Li
>> Zhijian <lizhijian@cn.fujitsu.com>
>> Subject: [RFC PATCH rdma-next 00/10] RDMA/rxe: Add RDMA FLUSH
>> operation
>>
>> Hey folks,
>>
>> These patches are going to implement a *NEW* RDMA opcode "RDMA
>> FLUSH".
>> In IB SPEC 1.5[1][2], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
>> added in the MEMORY PLACEMENT EXTENSIONS section.
>>
>> FLUSH is used by the requesting node to achieve guarantees on the data
>> placement within the memory subsystem of preceding accesses to a single
>> memory region, such as those performed by RDMA WRITE, Atomics and
>> ATOMIC WRITE requests.
>>
>> The operation indicates the virtual address space of a destination node and
>> where the guarantees should apply. This range must be contiguous in the
>> virtual space of the memory key but it is not necessarily a contiguous range
>> of physical memory.
>>
>> FLUSH packets carry FLUSH extended transport header (see below) to
>> specify the placement type and the selectivity level of the operation and
>> RDMA extended header (RETH, see base document RETH definition) to
>> specify the R_Key VA and Length associated with this request following the
>> BTH in RC, RDETH in RD and XRCETH in XRC.
>>
>> RC FLUSH:
>> +----+------+------+
>> |BTH | FETH | RETH |
>> +----+------+------+
>>
>> RD FLUSH:
>> +----+------+------+------+
>> |BTH | RDETH| FETH | RETH |
>> +----+------+------+------+
>>
>> XRC FLUSH:
>> +----+-------+------+------+
>> |BTH | XRCETH| FETH | RETH |
>> +----+-------+------+------+
>>
>> Currently, we introduce RC and RD services only, since XRC has not been
>> implemented by rxe yet.
>> NOTE: only RC service is tested now, and since other HCAs have not
>> added/implemented FLUSH yet, we can only test FLUSH operation in both
>> SoftRoCE/rxe devices.
>>
>> The corresponding rdma-core and FLUSH example are available on:
>> https://github.com/zhijianli88/rdma-core/tree/rfc
>>
>> Below list some details about FLUSH transport packet:
>>
>> A FLUSH message is built upon FLUSH request packet and is responded
>> successfully by RDMA READ response of zero size.
>>
>> oA19-2: FLUSH shall be single packet message and shall have no payload.
>>
>> oA19-2: FLUSH shall be single packet message and shall have no payload.
>> oA19-5: FLUSH BTH shall hold the Opcode = 0x1C
>>
>> FLUSH Extended Transport Header(FETH)
>> +-----+-----------+------------------------+----------------------+
>> |Bits |   31-6    |          5-4           |        3-0           |
>> +-----+-----------+------------------------+----------------------+
>> |     | Reserved  | Selectivity Level(SEL) | Placement Type(PLT)  |
>> +-----+-----------+------------------------+----------------------+
>>
>> Selectivity Level (SEL) – defines the memory region scope the FLUSH should
>> apply on. Values are as follows:
>> • b’00 - Memory Region Range: FLUSH applies for all preceding memory
>>           updates to the RETH range on this QP. All RETH fields shall be
>>           valid in this selectivity mode. RETH:DMALen field shall be
>>           between zero and (2 31 -1) bytes (inclusive).
>> • b’01 - Memory Region: FLUSH applies for all preceding memory up-
>>           dates to RETH.R_key on this QP. RETH:DMALen and RETH:VA
>>           shall be ignored in this mode.
>> • b'10 - Reserved.
>> • b'11 - Reserved.
>>
>> Placement Type (PLT) – Defines the memory placement guarantee of this
>> FLUSH. Multiple bits may be set in this field. Values are as follows:
>> • Bit 0 if set to '1' indicated that the FLUSH should guarantee Global
>>    Visibility.
>> • Bit 1 if set to '1' indicated that the FLUSH should guarantee
>>    Persistence.
>> • Bits 3:2 are reserved
>>
>> [1]: https://www.infinibandta.org/ibta-specification/ # login required
>> [2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-
>> Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
>>
>> CC: Jason Gunthorpe <jgg@ziepe.ca>
>> CC: Zhu Yanjun <zyjzyj2000@gmail.com
>> CC: Leon Romanovsky <leon@kernel.org>
>> CC: Bob Pearson <rpearsonhpe@gmail.com>
>> CC: Weihang Li <liweihang@huawei.com>
>> CC: Mark Bloch <mbloch@nvidia.com>
>> CC: Wenpeng Liang <liangwenpeng@huawei.com>
>> CC: Aharon Landau <aharonl@nvidia.com>
>> CC: linux-rdma@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>>
>> Li Zhijian (10):
>>    RDMA: mr: Introduce is_pmem
>>    RDMA: Allow registering MR with flush access flags
>>    RDMA/rxe: Allow registering FLUSH flags for supported device only
>>    RDMA/rxe: Enable IB_DEVICE_RDMA_FLUSH for rxe device
>>    RDMA/rxe: Allow registering persistent flag for pmem MR only
>>    RDMA/rxe: Implement RC RDMA FLUSH service in requester side
>>    RDMA/rxe: Set BTH's SE to zero for FLUSH packet
>>    RDMA/rxe: Implement flush execution in responder side
>>    RDMA/rxe: Implement flush completion
>>    RDMA/rxe: Add RD FLUSH service support
>>
>>   drivers/infiniband/core/uverbs_cmd.c    |  16 +++
>>   drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
>>   drivers/infiniband/sw/rxe/rxe_hdr.h     |  52 ++++++++++
>>   drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
>>   drivers/infiniband/sw/rxe/rxe_mr.c      |  63 +++++++++++-
>>   drivers/infiniband/sw/rxe/rxe_opcode.c  |  33 ++++++
>>   drivers/infiniband/sw/rxe/rxe_opcode.h  |   3 +
>>   drivers/infiniband/sw/rxe/rxe_param.h   |   3 +-
>>   drivers/infiniband/sw/rxe/rxe_req.c     |  14 ++-
>>   drivers/infiniband/sw/rxe/rxe_resp.c    | 131 +++++++++++++++++++++++-
>>   include/rdma/ib_pack.h                  |   3 +
>>   include/rdma/ib_verbs.h                 |  22 +++-
>>   include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
>>   include/uapi/rdma/ib_user_verbs.h       |  18 ++++
>>   include/uapi/rdma/rdma_user_rxe.h       |   6 ++
>>   15 files changed, 362 insertions(+), 10 deletions(-)
>>
>> --
>> 2.31.1
>>
>>
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
