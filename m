Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DD77193C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 07:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHGFAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGFAl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 01:00:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CC10FA;
        Sun,  6 Aug 2023 22:00:39 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK3wY0dzpz1Z1Y9;
        Mon,  7 Aug 2023 12:57:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 13:00:35 +0800
Message-ID: <e4d0e004-e436-6a43-17d2-96c0fe4dd551@huawei.com>
Date:   Mon, 7 Aug 2023 13:00:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary
 operator
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
 <20230804035346.2879318-7-ruanjinjie@huawei.com>
 <f72991b36d6a449ea5cf476d438bcd1d@realtek.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <f72991b36d6a449ea5cf476d438bcd1d@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/7 9:42, Ping-Ke Shih wrote:
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
>> Subject: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary operator
>>
>> There is a ternary operator, the true or false judgement of which
>> is unnecessary in C language semantics.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
>> index 8580a2754789..8328b22829c5 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
>> @@ -27351,8 +27351,7 @@ static int wlc_phy_cal_rxiq_nphy_rev3(struct brcms_phy *pi,
>>
>>         for (rx_core = 0; rx_core < pi->pubpi.phy_corenum; rx_core++) {
>>
>> -               skip_rxiqcal =
>> -                       ((rxcore_state & (1 << rx_core)) == 0) ? true : false;
>> +               skip_rxiqcal = (rxcore_state & (1 << rx_core)) == 0;
> 
> skip_rxiqcal = !(rxcore_state & (1 << rx_core));


Thank you! I'll improve it sooner.

> 
>>
>>                 wlc_phy_rxcal_physetup_nphy(pi, rx_core);
>>
>> --
>> 2.34.1
>>
>>
>> ------Please consider the environment before printing this e-mail.
> 
