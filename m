Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8DC771938
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 07:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHGFAP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 01:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGFAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 01:00:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0BE10FA;
        Sun,  6 Aug 2023 22:00:13 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RK3xx5pCXzrSG3;
        Mon,  7 Aug 2023 12:59:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 13:00:09 +0800
Message-ID: <e694d4ce-037a-45c7-d2c4-67ede755a73b@huawei.com>
Date:   Mon, 7 Aug 2023 13:00:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 3/6] net/mlx4: Remove an unnecessary ternary
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
 <20230804035346.2879318-4-ruanjinjie@huawei.com>
 <fd3e9bb40d12421caaddda7279aece7a@realtek.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <fd3e9bb40d12421caaddda7279aece7a@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/8/7 9:41, Ping-Ke Shih wrote:
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
>> Subject: [PATCH -next 3/6] net/mlx4: Remove an unnecessary ternary operator
>>
>> There is a ternary operator, the true or false judgement
>> of which is unnecessary in C language semantics.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
>> index 256a06b3c096..1c289488d050 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
>> @@ -176,7 +176,7 @@ static bool mlx4_need_mf_bond(struct mlx4_dev *dev)
>>         mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_ETH)
>>                 ++num_eth_ports;
>>
>> -       return (num_eth_ports ==  2) ? true : false;
>> +       return num_eth_ports ==  2;
> 
> It should be one space between '=' and '2'.

Thank you! I'll improve it sooner.

> 
>>  }
>>
>>  int __mlx4_register_mac(struct mlx4_dev *dev, u8 port, u64 mac)
>> --
>> 2.34.1
>>
>>
>> ------Please consider the environment before printing this e-mail.
> 
