Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E78571A0F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiGLMd3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiGLMd2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 08:33:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C3564C7
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 05:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo74niQErVLyjsSI3VxHgLpO8GxY/HKq4nBAG56vy7D3R98X0jRtf3nlYsRQEeqi7mqdweNu99UfnaKIHjwB/85zHqFosb7Mh8hi57HXsVFU4UbeOD4bZW/omwSVRqn0Q0Y5oEl6IdXjBg/BNn5SZYiXOFOS+sgcW1+HPR0FJTlaumMblonUhm27qLh9xZN1znhpDAVpAaIpNURwxw7IhV3HvQEXtvi5k6RO4sA29U7pzJefraF8mFiREoBDbW6jyFLKubUkWc1zPHVNB4LDxRvmGnW+BLHnTlW6xgNUP7MdJJcaqC2w0EeSDzgeHOhxXlVBq1C/UWkk5LSUzR5r4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akA28hqNZVfD7E7u1m+I5Tvshe4LdcfApWV6m5b3JXc=;
 b=cY4l3JMG+KJWT+Hdv/s55Waax32bSowc/L+0eDSGt01U4JmEKEdXNgV3lg+WU2cbDM4ekJb+fHtUkStQJnBUbardfn9eyNgTFMSD8s/sC09biKj2k8J8/MR3QMzyWHlU4JDbSk/aEVo3dIakFGmAuktUqrpN/FUFcw5UOvw/CJbeHRl8Fwdz8Ip7tIU7P6ZUEKYtx8qm9+SWClszaT1xsP8bQpLW0s1CRuJAPTA+iDPbSdvg/JBSmWOG3+lsYNFaFrXCalNnOTBM4CbSkvGZiOIX+o68q1yV7uwKx2VIi/VCOZ3coHoJDsjQBW74+qcgpyveYQskBtoVAJe832susA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akA28hqNZVfD7E7u1m+I5Tvshe4LdcfApWV6m5b3JXc=;
 b=QNrgcBTuJhhgH/vF27GkL/lEe2pDcTEEuDcQPMS1WHJRjRNQhBDRgGcBSgvlgxpRaiDXES7ofyQfImXx2ax3vTu1dSDlIRyAu/2pSNdcXvGacK+5wdxneAvDR+9PC/mp5YK1jzaNpr2qFwPlrSbKQs/yLsDEpHfx76dk/nmTZH6rSqbQA8nq2/Il9SfnFVEQUIUlr3xSWw0kIwbSuuUUZasV33iQ9YcRLqPa60r1IFAsJ8V1BPURJRAqVehj4n7MVGU+zVSU69NJCX0xmydBiGnTVq95FXu8oeMQF4jwgU6sg52pfWYgOr4zeWPn9HTdDK4haHiqDRcscIH1klUuQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BY5PR01MB5634.prod.exchangelabs.com (2603:10b6:a03:1ae::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 12:33:21 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:33:21 +0000
Message-ID: <b1edc535-ee1c-13f2-df2c-5980261c84fe@cornelisnetworks.com>
Date:   Tue, 12 Jul 2022 08:33:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/hfi1: Depend on !UML
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com, Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <165755127879.2996325.5668395672492732376.stgit@awfm-02.cornelisnetworks.com>
 <Ys1E8fxDpXwl1bMk@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Ys1E8fxDpXwl1bMk@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaf65150-631b-4ee4-2f56-08da6402b4d4
X-MS-TrafficTypeDiagnostic: BY5PR01MB5634:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsgPhatPsrzidiFlc0n93NDJ8XQ0bviumT/lyyDv0ok1ZySaAit1c2mezCNsn5sgkQbq4cvEWdYvAwwItMgkKG1Hpj9vz5vSBpAqaeRpunn1Rvf5iIZT0K9t22TVbQD7/8m16nbOAw8WWMCQoXk1zteY/z/NvQnOxhg58S8g5cnMb+STRnYlo5GL3fRGYDWtGpmI22Sy0lELZmYpTj6ukDzZv5K3q2AC9B4RdUTMESxEXM/vkSgbI5hk2cwa2VNxs/llpmSSMpdXv4MltCwga0m1X+0brVF3RWCdcdcio9MurL8Z3tBfEg5InnS90hH1rFWzF252MzMId1b9pbVyw7Fq7+OT3Tycn9O1/6+CrdRnAZV7TLmiovjZs3+pVCYSJimpRiEApnvpEqDfBGYfps65JILLzwRIPxqKwimMzk2bXjhbh4ljLhkURLhxv5KxMB1yuLms+0hQFb61UObBkoTnM0b3z3QRsAf3QCO9ofrHydhNs3WbIieozqlMBhIKvD5wD8sKcGC9rvzoWMopgpKHijX4kb/SL+S4C8t9AIZjPOJe0bW3f2SNWg3m8uivucDMKOG5fariXIrOsMkKaL48zkhgt6+2SpURrzwnFGue1EbfFEDa5hf/RZe/w4ZossJSn5jBBfbcayxojYyCCcyWwjHzzKk+UGQQKon+jCUjqZYeiuC+tFAcaD8nVvXx13dVboXrtOvesdXVjDAJSxk7zWCuqk1qEo6YwFPkW+ZDqPPngaXoJ+0JoBqkqxtuIxIQtSpxLuqEi0PV7xJs9OWiAlGVH0mPONYODhFoviovmXmE18NpB7snR7xOdvActzil2O5r8+lL7uGnjzaVTKWL1ixxWo8uYN6AOfw5lPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39840400004)(366004)(136003)(966005)(2616005)(316002)(6666004)(44832011)(186003)(41300700001)(4326008)(38350700002)(38100700002)(83380400001)(6486002)(86362001)(5660300002)(31696002)(8676002)(66556008)(66476007)(66946007)(478600001)(6512007)(8936002)(52116002)(53546011)(6916009)(2906002)(6506007)(26005)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhWMUZaSEQ2RTd6cmVaN1JqRnNHOHViTnBGazZzMzZTSlJ5cExOT2ZDanNG?=
 =?utf-8?B?aVBzOHUvRDJ0c1ZqUVZFZkMwWWdqa1I2VjZaZjFHOTlybTJHWUtmSmpBWk5t?=
 =?utf-8?B?UUdDUkI5Y1ZxVU9aYk9zUGJvS1lKc2U2ZFk1NjlJZFk2RllhM3NmZ1FkWW5I?=
 =?utf-8?B?dFIvcEwzR0VRbyt4RFJCb2xiYWYvN1ZYZ3k1d1dOUVNTa2o0RHNXNXVtUGt3?=
 =?utf-8?B?dlQ0R3JKRWtpUnBNa2l6Zjc3b29QMlFObXNibXc0RGxIcDliT3dhNDhDY0w0?=
 =?utf-8?B?MEd5T0NmK09IYUxoQ1FHTEM2OUYvL25IcVl5THl3OTVERC8zbHVZS0JKYlRa?=
 =?utf-8?B?eE9KU1RveXdzUHJyVlVqbXI2T0k0ZkdHVzk2Y3Z6WDZDZmROQjcwTnZqTjlh?=
 =?utf-8?B?eU1LNGc4OGkyQ0k4dWlnKzNtemhCYXlmR0lqVnFpRGxSdDhpSXBZWGJMNS9G?=
 =?utf-8?B?Z2NnbVM1RktiS2ZhQXc0ajR1clhQR2hlRWJKNUVlQjR1VXpRa2ZCM2c3anh1?=
 =?utf-8?B?aW5MYVdMSmtzZHVKdUhubUt3bHIxaDRUcFY2Y1ZRaFdjWkJ6UFFUS1J4U0ZL?=
 =?utf-8?B?N2psQXZNQnYrb2wyekI4eUpzRC8rSkd4VVJZN0RqTTlWSlVwYkIycHVXZUdm?=
 =?utf-8?B?dmt5SCt6WC9zZ0lrNHhyMUxyOCtjV2hPc0dDVzVGMDFBdUJMZ0F0N00yRmdM?=
 =?utf-8?B?eEEvMjlTdFV6cUdTVTZBb1lSUk5qM0VzTFRvUUpwSjlwbDBhUzh4aVdTcGEy?=
 =?utf-8?B?bitidFBZSmRkaWdDZExOaVI2NGFlV1VtemdJSHRod1BBQ2l0SWEvT1ZCdW8r?=
 =?utf-8?B?bGZ3QnUzWlh5YXpMWVhLK0FManBkUk1YNWdXOHdRMlkrcTk4Z0VhUWl1eVJE?=
 =?utf-8?B?KzN3RTFzWmIyejNpQW1kZnlNaHZvMEVnTzM0REIvbFVGMmRzcGJORkJXcFdT?=
 =?utf-8?B?VHc5eW9QM1RyRGxFSlBkVzVlazlWSHdNKysxczlzVWdaYjRKNnBaOFM2ZFE0?=
 =?utf-8?B?N2t4NVE0cWdzbmFudUFueW9aV0tFS21jN1IyMTNxYlhZSU03djdlNFRwbzlt?=
 =?utf-8?B?SnJDbkVLZUZQbCtYUkQ0ZSs0MnBYVTEraXQydDcrZEpTS3FBalVpTVRkZU1S?=
 =?utf-8?B?TENpUUU4bUhHN25LWTlHbS9UQlh5RWx0bEl2WmFkSWVQN1M0V0ZaRjJyaUVX?=
 =?utf-8?B?d3Vaem4xV1BMcHFPK1pzUGhsd0hQUXhDOS9QQklsVEY1N1p5a3dyNVBpVXhy?=
 =?utf-8?B?UE9LTjJ1SVlONFl5RjlmOSt4NlVQTmFKbnQzTXRjUFRZVnBUYlpGSEpoVGhN?=
 =?utf-8?B?UjRFYXlkbjBOSnQ2M0F2QXFTdGdvNFppNTdjSy9DQUlJUmVwWjJwV3h3U3ll?=
 =?utf-8?B?U0pEcTB3bUtqbnBVVFJsQlYveWJOa2o3NktpQXdEK2tXZU9sQ1BMaEl2NUto?=
 =?utf-8?B?MVhxQ2p1aDNJYU5WV3R5Tk0reFJtSzZjVytoa2FNZmpUbTVDRVVYOEtlZXQ2?=
 =?utf-8?B?alFmWnBzWnFWZ2xwUmozbCtkSkFvUTkzSTg5VVBVU3d0bnJhY2twK2EwRUJa?=
 =?utf-8?B?SHlzYXE2TjkxQloySGFmUDM2Ukt1c0dVU1h2NXVPV2xtRUsrY1BWMDFwRER6?=
 =?utf-8?B?WUp6VU5rM3RBNWFWNVF2VlBKU0JCYjNjTUUwdXVSb2w4QkJGd1pKVmVDM2FK?=
 =?utf-8?B?Q2l6KzJBU0s2NGV3SnNnSDlPVzhrNkIzV0ZwNHNxMFBjeUsxcXhvYkNEU09l?=
 =?utf-8?B?TVU1L1F1SHVCMjI5MC9QUk45ZkNaYzAvTmN5NEV3WVE5VXNUZ2dlZWsxV2J6?=
 =?utf-8?B?U3F2bEtmbmFBcGEyMjAvQlBFdmNidjJQUzI4M211WFZ0VVJFSHpTUENjS1Nm?=
 =?utf-8?B?OU05aTRpdXIrQjVkWHpFdW51V25sRHNoYnNTVGxsYlM3aGNLMUtVRDl5eVZX?=
 =?utf-8?B?TlBxRlJTdkg5Mlh5TERYNjlnUjhOY0tVc2w2S2VKYnVNbjlZUUtWbGdkeHlC?=
 =?utf-8?B?Y1NFbnBDKzN3RndpT3FrdWtPY0FpcW1tdjJsdWIxdEF3THVjN2hLVkd0YnJ0?=
 =?utf-8?B?ODkvc205d2hzYk15VTlaTkJZVU5PakhPbTlkajI5M3Bkb1lELzRETFZSbFp4?=
 =?utf-8?B?TkpSOUQ4U3RjZCtmQWlVS251ZlBVZEEvSkRuTDRveXBNSGVONC8vQ2J0b0lE?=
 =?utf-8?Q?NExJlk7KYqp7wmxIx/IEtp4=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf65150-631b-4ee4-2f56-08da6402b4d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:33:21.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi2yxBcLkbZXXL1KlNEN7ZPR24fX8kfHwLAFuKitZYUBjy0ojBCWKKnFcy6ZCKU5ZVwRY9sAosBrzFYW6pqLQEsKtJchzTBrihVmSbAuUQ9QoLM0Cm5cGR+61CjZPQFl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/12/22 5:54 AM, Leon Romanovsky wrote:
> On Mon, Jul 11, 2022 at 10:54:38AM -0400, Dennis Dalessandro wrote:
>> From: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
>>
>> Both hfi1 and UML depend on x86_64, this can trigger build errors.
>> This driver must depends on !UML because it accesses x86_64
>> features that are not supported by UML.
>>
>> Signed-off-by: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>  drivers/infiniband/hw/hfi1/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)a
> 
> But why is this hfi1 specific change?
> Shouldn't CONFIG_UML be disabled if someone choses !x86_64?

This was discussed in [1]. Perhaps there is further work from UML folks
warranted. However there really isn't any reason to try to compile a HW driver
like hfi1 for UML and this will silence build warnings.

1: https://lore.kernel.org/linux-rdma/20220102070623.24009-1-rdunlap@infradead.org/

-Denny
