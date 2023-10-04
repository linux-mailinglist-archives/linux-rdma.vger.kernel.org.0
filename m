Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85597B89EB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Oct 2023 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbjJDSag (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Oct 2023 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbjJDSaf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Oct 2023 14:30:35 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8DC0;
        Wed,  4 Oct 2023 11:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYTyXqOFR4IB/0KgRcWGGKf1oGWo/WZrw+AEgmBBGwDbvPEm8K+hxvFb4mB0ZxEbaFf4zRBKw939QXlbQpSPsKuF4uXQTyvoikUjg9ceIvsrTOYv7TDKSdc1UYuEc1R5B53iVq6yVowCenXEhh0+JTzZ7vnOSNIalrj5l1CjLMqUNtmrVswq1737XmFw4yylyfkrFL98rNavp+MzNb0yRWxOoziQFR28EEtAe/fc+VJyT/20FIsEwTGBSFRVPTlCedQ8HgHG+w1cbFC84TZFrH1QvSq5Oelnm4xRyeQwefVAR1EVRQhT8/eIFBwm+uSiie6kuis9G6FDTIf9O1sN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuJJ9Y7ghNEgezJivFXHCJBEQv/EBcGYAdOjNfx+ssk=;
 b=MX3HIcPF/Gzsv48KvguDcdxZZ+YATHp+eBq+VXdqeG7YEWwUtc2r5pkG+NtRvkn/gGQVNv+O+/JY3jBuHZE8kE2KU8qmT0GLfdsYMKTxxRETB5BiPxLFOSvS6VAUpr4IF3tV3rCXDULDGAFgBH2tFDmEfWrBux3QfCmz4P0ey7b+TsGf7mCC/xRO0xV6ZM8PbDdP2jeQH4PNDz5W5XYQrd9RNVRmBVMXTbv5IdONGYWcle/tp8FPauluZ/us4EXOPlyZknG0fphg36id1YffYr40QaqP26dqKl2xEZBCFX1t/NA/D2pPxkRpqlO25W1nasHFc4/57Wx8Iuo5evP1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuJJ9Y7ghNEgezJivFXHCJBEQv/EBcGYAdOjNfx+ssk=;
 b=BbzPlc4R2mGpKY4trF1XtHKN2uBRR3BAKRzkpZ+0hQpDBE/Ras20Ugcv+WebNLzHyYwbiRCW/bntsfKH1FnsLzxnA++Mv92Yl9C6l08apAkaEfr2/Z5Qd2oSZ8tqa+8+ZgVdPVx9EvtW/zmZtHO7rYpxpmDyzNkPdqWd2xEyz1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7971.eurprd04.prod.outlook.com (2603:10a6:20b:234::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 18:30:28 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:30:28 +0000
Message-ID: <f4d355cc-66c0-1757-4a9b-781db451cfbc@oss.nxp.com>
Date:   Wed, 4 Oct 2023 21:30:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only when
 update_pn is true
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, borisp@nvidia.com,
        saeedm@nvidia.com, leon@kernel.org, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com, sebastian.tobuschat@oss.nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
 <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
 <ZRwT76YcQAFXKD4k@hog>
Content-Language: en-US
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZRwT76YcQAFXKD4k@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::39) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 6386674b-eafd-4a9b-3f61-08dbc507fb60
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWL1bovQ3bfICoZulOUZYt2eCeM/iYV3SyjB/6q22mQieGNtUHRmGj0QbE7hztP/3sIxMvcWdDjHOVqtaOy8YPMZlg3VeP2A4MrWom1od7BzCLaCKdiMY5pjtYOFkexsc0V3A7iBIWqYe+aQqeFwClfNYEdoijbunSC/pxyC9GNJYEo+22okQkzlF6Dpb14xp2Vs4RbJ7W5kROCk5GcuPUya7Mu64uq3jfg9mUVm2riEr9pneQDzijFlzSpORgzljeBmfxsyjEVfyn1G3tde0D/p2hth2WjkxeZ9RWNuMDfz2nKrLzI/PNIPjtaN0qMifgNNgqSUT9NYBtp2I4HDhcLXItYg0z1ClPSuWHaEVmkiwUKgVhuCKAHCHH/Zo0bSg3+B8SxGbyE0CdPo01qM3Zj94TGSHCfLL3pTt/gCDuq52SNL9poDS0QOQngH236AJ/GVK0XhDSFncAReZ6fEzFqN4vGBDfauZ+Sm5nffdLVkcDMIhJ+qsNUkUgYxdxPFsaxDa/nUzm45hdRwYbbrHEj/XRU4EK69CzeL4aH/iMuy0rumIIjL+4O3TRPVyOMGbTEhRxc4G2I/dwrkoo3ngpnzZUMKAEA0TyepLVVLEsGwT5cl/WFiKj+TlrJKhWLoOCXivEJ3SKa0fJN78jEkcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(4326008)(15650500001)(31696002)(26005)(86362001)(8676002)(5660300002)(4744005)(53546011)(2616005)(6666004)(8936002)(6506007)(6512007)(7416002)(83380400001)(66946007)(38100700002)(316002)(6486002)(2906002)(66476007)(41300700001)(478600001)(6916009)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRkbzBnRW1JbVZSS0tpWStJSzNiUWFvZjVLakM5KytuMytNRTB2N0Zad2Mr?=
 =?utf-8?B?YUJKblZOQ0RxMDUvelYrcnkzSDJpUG4vTGF3N2xIMVNvWHMvNGQ1MDQ0Z0hL?=
 =?utf-8?B?T1RraDRTQTkzOWNCa0lTWC9lVGY4VDhoZU83QzhHb2lQUVlORnpuMWd1alI4?=
 =?utf-8?B?TTZLNTdoNVdHdkMrUWgrUDJsM1NHM0RhTncyeElCblhEVi9ubW5tZ3JSWElm?=
 =?utf-8?B?a2syZzhCQ2t4cjZwL0ZaYWlhSkZhT3p1NFBPUHFhc3FIc3orWDYwRWZWcEZ4?=
 =?utf-8?B?OUMxM3VUbnhZaHpuQjJwdUVBNXpKY2VkNGtieW1BSjVxdHpDelNGTENOVktz?=
 =?utf-8?B?aDVHaTJTNVdhMnZsTTZLbkk2MzdxMngxT25wNWY4Y0FWc0hyQUwzaC9jaVc3?=
 =?utf-8?B?VHdsQUVZN2Y1eWFudkVRc090Vmc3MkRuck53MmVvNUx0dXUxUDN0MTVjeEN4?=
 =?utf-8?B?c01hRWVaTzhOanZUYzBtNXdEclNRMk53aGpja3JaeW1wc0ZsWDJKYk1xek9r?=
 =?utf-8?B?Wng1eXZYcnM4L050UkdKTnhUUkFGSm5DNVJHTzBhVExHR1dLK1NSb2U2dG5C?=
 =?utf-8?B?bFRJK3F1WGp1WTRVcVQrTFFaTzFwTStDWjNpVUEzNmx0cHZtU2ZtVkRDODdS?=
 =?utf-8?B?M0pqUkZ6MUpXWVVFN2xkdHVSVzJ5QldkZlJaSmthVXlBWTlMQStYSG4yRm9z?=
 =?utf-8?B?UGlyalpTWFFoeG5aN2FmNWVuL0t0bktGY0Vvd2Fta2VXVmFmMWRCOURUbHhU?=
 =?utf-8?B?c3d5QWdqMi9zU1Q5STd6NXhacytEUGw0Rlh0QmxKalI5T3FzTUlPMGE5cnMx?=
 =?utf-8?B?Y3VtRjR1NFlyOG11MEhLb05MTlhJOGYrZDdZMWFkNWRTKzU4b21LT1pUN2FT?=
 =?utf-8?B?YVBpaWp2dldhWEM3ZytFc2lxbTM2OThRRkxjTnVvSVVocVp5Z1BMblVPV1JB?=
 =?utf-8?B?VENXWlZBUFJSVG1Yb0R5ZituL1lNYnZVWjJvOTdFTXZpVHVBb0hmcno1ZmYz?=
 =?utf-8?B?L2l5V0tRdUhLb0VPUW5MbitmT245KzJKMVVGTzJyTFV4S2xLbCt1ckVaTEZK?=
 =?utf-8?B?RnNrOHdBYVRlUUtTRnVvY0MyUzFIV3BETm10VDhaYUtzejhyWG5kK0lvcnJP?=
 =?utf-8?B?UXF3N2liTXI4K1A1dmIremFTL2diSEc4UW52RlRTeHNhenM0M0s0bThMdGFC?=
 =?utf-8?B?MUZ2SXBWVHZDV1RqQmMvQUZMRDZ1a3cxVFFTazVEc3VrWXdrZTVtRnAyWWdS?=
 =?utf-8?B?RW9QM2daS1JtTk1rWUo0bEJLOTM3MytjTHl1eVdZSTZkV2I5dDVCNXJ3T0NY?=
 =?utf-8?B?WTdvUi9BQ21YTXJHenVOS2VkVWVUL2hteEhvTFVJSnAvK2I3eGQ5VE1DaG03?=
 =?utf-8?B?TElFeVdvcmVUSHBVaTBjOXlTbXpORklmSDJKb0ZLZ0hkcDJEUmFNc3JZM005?=
 =?utf-8?B?Q3ZIajhLMEpDckZSWDdzUVpDYS9kci81a1lsQmNob081RUIvMXF5S1haaisx?=
 =?utf-8?B?d1JKcGJqUno3OGZTaE1yMy8yZndWZ3A2MlRFV3RiQ0ZYZ2NSR3g4TGt6ZW9E?=
 =?utf-8?B?Qm5EcXBDWjRkZE1KWDhYSDJzeGdDSUUrM3NMY0hTNVgxK0xMcXFYeEhHOEF3?=
 =?utf-8?B?RitnZUhhUUtpRnNSVHRxeVZJWDlhVHQvVmdWT2JQaXNWOG1kbmVleWVtRitu?=
 =?utf-8?B?Um5VSGFUMHlkd2FpVGZyTDZ2L1poK1dCa0wyeG9WWVpkOWpQRUJpSDUvekJX?=
 =?utf-8?B?NHZQaVpVZlZ1SlcrN0VVWEM4b3NlUURMYmx0bkdDU1dyWkVPUThsbWk4THRF?=
 =?utf-8?B?NkVwMm0yVDV5dzlrUTFieWcweHpHYk5DeTB3U3oyTDU1UGd4YjdlN2pWREFW?=
 =?utf-8?B?SHhUSmt6cyt1eU93bVAzSGpTZlU2TjIrM0NKNFBhaG03UmM5K0E0ckp6dm14?=
 =?utf-8?B?T3ZaUi9WUEREbWdiSFBxMDNIK3YydXV6MnVwdWxwWmtnSUgyZTdtNzhNOWVq?=
 =?utf-8?B?aVdHdFpYNzRXS0NGVVZ4eFpiVWhUMVdIWkRjcUZYL0hpcEFPUTVVVGphRVVX?=
 =?utf-8?B?TDlTVEh5MmhFUGk3dmtKbVRhaFRJZHpuNC95MU45QVUrSTNUMzZrMWtxSnp4?=
 =?utf-8?B?aDVkazVwR1NmMlNXZmpDczI4QWJQWm0za3pwSVR1d29vMW80TmN0ck9IU25K?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386674b-eafd-4a9b-3f61-08dbc507fb60
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:30:28.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iJ12EPwa6MKwdabhcua6iW4JgXyl7+hqn/4G51L3nr8olbFzyDRpQ8RECJe5TZdBO9df2f3bPmKQdjW7F49g8WrzNwUiQLZB48juI9sdf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7971
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 03.10.2023 16:15, Sabrina Dubroca wrote:
> 2023-09-28, 11:44:25 +0300, Radu Pirea (NXP OSS) wrote:
>> When updating SA, update the PN only when the update_pn flag is true.
>> Otherwise, the PN will be reset to its previous value.
> 
> This is a bugfix and should go through the net tree with a Fixes
> tag. I'd suggest taking patches 3,5,6 out of this series and
> submitting them all to net, with a Fixes tag for patches 5 and
> 6. Patch 7 doesn't fix a bug and could go through the net-next tree.
> 

Patch 7 does not look like a bug fix, but it is.
Without patch 7 a user will be able to update the SA using the initial 
PN value like this:

ip link add link eth0 macsec0 type macsec encrypt on offload phy
ip macsec add macsec0 tx sa 0 pn 1 on key 00 
ead3664f508eb06c40ac7104cdae4ce5
ip macsec set macsec0 tx sa 0 pn 1 off #this command does not fail, but 
it should

-- 
Radu P.
