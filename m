Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFE771934
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHGE7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGE7s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 00:59:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C984510FA;
        Sun,  6 Aug 2023 21:59:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RK3xM2nf2zrSFk;
        Mon,  7 Aug 2023 12:58:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 12:59:39 +0800
Message-ID: <815f4639-7a21-4438-b9dc-0b36f9b08b17@huawei.com>
Date:   Mon, 7 Aug 2023 12:59:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary
 operators
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "lee@kernel.org" <lee@kernel.org>,
        "set_pte_at@outlook.com" <set_pte_at@outlook.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
 <20230804035346.2879318-2-ruanjinjie@huawei.com>
 <15759f98483947999393a25b857bc4fe@realtek.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <15759f98483947999393a25b857bc4fe@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/7 9:39, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Ruan Jinjie <ruanjinjie@huawei.com>
>> Sent: Friday, August 4, 2023 11:54 AM
>> To: sgoutham@marvell.com; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> jesse.brandeburg@intel.com; anthony.l.nguyen@intel.com; tariqt@nvidia.com; s.shtylyov@omp.ru;
>> aspriel@gmail.com; franky.lin@broadcom.com; hante.meuleman@broadcom.com; kvalo@kernel.org;
>> richardcochran@gmail.com; yoshihiro.shimoda.uh@renesas.com; ruanjinjie@huawei.com;
>> u.kleine-koenig@pengutronix.de; mkl@pengutronix.de; lee@kernel.org; set_pte_at@outlook.com;
>> linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
>> linux-rdma@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-wireless@vger.kernel.org;
>> brcm80211-dev-list.pdl@broadcom.com; SHA-cyfmac-dev-list@infineon.com
>> Subject: [PATCH -next 1/6] net: thunderx: Remove unnecessary ternary operators
>>
>> Ther are a little ternary operators, the true or false judgement
>> of which is unnecessary in C language semantics.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/cavium/thunder/nic_main.c    | 2 +-
>>  drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c
>> b/drivers/net/ethernet/cavium/thunder/nic_main.c
>> index 0ec65ec634df..b7cf4ba89b7c 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nic_main.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
>> @@ -174,7 +174,7 @@ static void nic_mbx_send_ready(struct nicpf *nic, int vf)
>>                 if (mac)
>>                         ether_addr_copy((u8 *)&mbx.nic_cfg.mac_addr, mac);
>>         }
>> -       mbx.nic_cfg.sqs_mode = (vf >= nic->num_vf_en) ? true : false;
>> +       mbx.nic_cfg.sqs_mode = vf >= nic->num_vf_en;
>>         mbx.nic_cfg.node_id = nic->node;
>>
>>         mbx.nic_cfg.loopback_supported = vf < nic->num_vf_en;
>> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> index a317feb8decb..9e467cecc33a 100644
>> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
>> @@ -957,7 +957,7 @@ static void bgx_poll_for_sgmii_link(struct lmac *lmac)
>>                 goto next_poll;
>>         }
>>
>> -       lmac->link_up = ((pcs_link & PCS_MRX_STATUS_LINK) != 0) ? true : false;
>> +       lmac->link_up = (pcs_link & PCS_MRX_STATUS_LINK) != 0;
> 
> lmac->link_up = !!(pcs_link & PCS_MRX_STATUS_LINK);

Thank you! I'll improve it sooner.

> 
>>         an_result = bgx_reg_read(lmac->bgx, lmac->lmacid,
>>                                  BGX_GMP_PCS_ANX_AN_RESULTS);
>>
>> --
>> 2.34.1
>>
>>
>> ------Please consider the environment before printing this e-mail.
> 
