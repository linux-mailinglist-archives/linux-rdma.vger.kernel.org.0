Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54B4B762F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiBOSXg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:23:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbiBOSXf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:23:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC8C4E29
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:23:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2zwiNrSskI2z/g95Qbax3cL2SuaCRZvH6krZZPSvtnK05aH9LE/WfG5vRD6NTxSWgPtXrIkza5GDWazd24QPQ3zF280TvxP02XNL++F0tGdCqs3qIXWRnmrTw/XGU3m0qJSvPELo/GsjA112L+FgEelZLvB6MnBCoUf9Az+bTiOb5est7FbWUDm5silWDcMDIh42mTsYOM3nCacwxhkKpnt/ElVoNKFVdzAWGWpdgcs0TPoHYqr5e4cSLr0k3xLlqY2oD/J8iSO2R8kKb7XK3oBtrpKK+pKkXMeqGv9GbY8boR1cbL3fZS/nCnsxm+jItVWqiV2Ys3if09qRdCdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WXMKXDMrg55EfmIKYzRyT0Lbva91/z+JDGj4vnqafA=;
 b=IdPbJuT7rCfeA6er7gjiNbghsf7+ritI2fP0d8YV2wsp/q50C4/8OYnE0NeDHZgnSgQBG4E1pIWNLEN2kxiehn6lXviKxrywHhNdJUPx7EWHtjRbZgiOlrn3aJF+8alyPQWNWNh/JLKWuEUFv5VJvkcphcGf4FA5VKncwUuZCn+s7Kdp3GJapvbaIQfyLk65tgO9viwy2nOYyMuA8d9jW6/IKUyPUvyZsP/QXK+w0Ta+UFHn7XsGlydTCn5HBWn4uJbf4sCJlYCnZEO76HXqP5FKWg3dvGqLpz7g+J+Ii3BJa0SO6XjADgU9YfSM+uP4X5+0P49XuplmDJbucIrcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WXMKXDMrg55EfmIKYzRyT0Lbva91/z+JDGj4vnqafA=;
 b=U2TepjlRg7F/jHplvMsNzR0B+ctXTUNe2zDzQKIIlTgo8LBQtmVercUd9XPP3k3r/RIiP6p35vv6sSN/Rxs7z64PNCgBshFkrzUeaDhT2oXbM/73xPv6367JqONmLhmbvdL8rCq28OvlRwmt74HZl4miPKamMyW85OLUHc4KW47eZ9+3OsimRacU6a4iYHsYIKeyhcpZxTnIO/PzPFSVpOLeZboCX0g5lxL2DYPzWHXHuSOwDjg+G+6RLyPRbsY+ZRe4tbaCmojNMqcXhnDTes/p61UOHq05eB7B4tkqV3OTJYCqJsvVVbkjwdbDp2RnRieiYjISioInCDKwik4KnQ==
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 18:23:23 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::f) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Tue, 15 Feb 2022 18:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 18:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 18:23:21 +0000
Received: from [172.27.0.132] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 10:23:19 -0800
Message-ID: <7787e4da-1714-67dd-990a-a89168548cab@nvidia.com>
Date:   Tue, 15 Feb 2022 20:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/4] IB/iser: remove iser_reg_data_sg helper function
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <sagi@grimberg.me>,
        <oren@nvidia.com>, <sergeygo@nvidia.com>
References: <20220215110632.10697-1-mgurtovoy@nvidia.com>
 <20220215110632.10697-2-mgurtovoy@nvidia.com> <YgupdG6M/TZL20iX@unreal>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <YgupdG6M/TZL20iX@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88ad517c-55b3-4b21-c168-08d9f0b04042
X-MS-TrafficTypeDiagnostic: CH2PR12MB4149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41497821FC93EBE8622C8B9ADE349@CH2PR12MB4149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIGqwtUOD1sFmQ1M/UQ1pDtpa2GLHqj4JI+g28Czx1sB1Rhr9FFuy/v3uMnsIJa0wmIyTDbOCflpU4+ahlpyHa6utkYWwwWBGEZZiFIuSvyQywwRMJuSLUgeHzUJTEzfXU0747Q9r0ZwLhv063b3ekY77Tz3XIHNOQyth0BeNEbWffVfNuA7Jz1huYjDsBSkUqBeAWvP3U6ARByHrX6S3sVne2HWVP0dVMkX6iu6EKhquJ/ODxuIS2k9u+T/rWDxtw0if7XKHdo7mbMhtYmYIJ4/UatfaaI0ZT/+rKva1euMaIBsGTGUXDGBZEF1wakvDphoKzO3RjqxAx57FgcLpgmvxDFsKjzoovlGI/eyc9V0637FUQljKNZkr9H0aciUCQVJyKTenWu7zWu+NKTqQ6TEmyuik5V3dVO64GBS8DZ2mi5txSrw1rcY6UtJ3gFy3/SOGVq+RlZMPXXhXB+YaxmOzcp2Psx4NBCEC9FCUa65yDr8+q+k2sboAYJ2qEUf0FDk7w1xKCugFvEKh4eZntHPiKpnJx+eYH4IVHogRg8F7+Zr6U1ShuUxrXLk+Kt1R6107AVqyeYoeCFPSGoNpT44AmiZ8tty0kq3P1V1sVM9/s42s7x0EYaE1r1qi4mnax0s4CHPxYy3aHXLEG0aLjug/1hn8EZEtwtiG7csKiqumU+ovd2DlhHy/KwwvnB8gjo3x6i/fzh/kW/7zSerLwL9SXgvmdQRTPRDSU2ggGtCithir0iF8Hv/dtU/2WDu
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(53546011)(2906002)(107886003)(83380400001)(2616005)(186003)(16526019)(26005)(336012)(426003)(47076005)(82310400004)(508600001)(31696002)(70586007)(8676002)(36756003)(31686004)(16576012)(40460700003)(86362001)(8936002)(70206006)(6916009)(4326008)(6666004)(316002)(356005)(5660300002)(54906003)(81166007)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 18:23:23.1569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ad517c-55b3-4b21-c168-08d9f0b04042
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/15/2022 3:24 PM, Leon Romanovsky wrote:
> On Tue, Feb 15, 2022 at 01:06:29PM +0200, Max Gurtovoy wrote:
>> Open coding it makes the code more readable and simple.
>>
>> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/infiniband/ulp/iser/iser_memory.c | 32 ++++++++---------------
>>   1 file changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
>> index 660982625488..2738ec56c918 100644
>> --- a/drivers/infiniband/ulp/iser/iser_memory.c
>> +++ b/drivers/infiniband/ulp/iser/iser_memory.c
>> @@ -327,40 +327,29 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
>>   	return 0;
>>   }
>>   
>> -static int iser_reg_data_sg(struct iscsi_iser_task *task,
>> -			    struct iser_data_buf *mem,
>> -			    struct iser_fr_desc *desc, bool use_dma_key,
>> -			    struct iser_mem_reg *reg)
>> -{
>> -	struct iser_device *device = task->iser_conn->ib_conn.device;
>> -
>> -	if (use_dma_key)
>> -		return iser_reg_dma(device, mem, reg);
>> -
>> -	return iser_fast_reg_mr(task, mem, &desc->rsc, reg);
>> -}
>> -
>>   int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>>   			 enum iser_data_dir dir,
>>   			 bool all_imm)
>>   {
>>   	struct ib_conn *ib_conn = &task->iser_conn->ib_conn;
>> +	struct iser_device *device = ib_conn->device;
>>   	struct iser_data_buf *mem = &task->data[dir];
>>   	struct iser_mem_reg *reg = &task->rdma_reg[dir];
>> -	struct iser_fr_desc *desc = NULL;
>> +	struct iser_fr_desc *desc;
>>   	bool use_dma_key;
>>   	int err;
>>   
>>   	use_dma_key = mem->dma_nents == 1 && (all_imm || !iser_always_reg) &&
>>   		      scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL;
>> +	if (use_dma_key)
>> +		return iser_reg_dma(device, mem, reg);
>>   
>> -	if (!use_dma_key) {
>> -		desc = iser_reg_desc_get_fr(ib_conn);
>> -		reg->mem_h = desc;
>> -	}
>> +	desc = iser_reg_desc_get_fr(ib_conn);
> It can't be NULL,
> iser_reg_desc_get_fr():
>     52         spin_lock_irqsave(&fr_pool->lock, flags);
>     53         desc = list_first_entry(&fr_pool->list,
>     54                                 struct iser_fr_desc, list);
>     55         list_del(&desc->list);
>
> If desc is NULL, it will crash.
>
>     56         spin_unlock_irqrestore(&fr_pool->lock, flags);
>     57
>     58         return desc;
>
Right, nice catch.

I'll remove the check in v2.

>> +	if (unlikely(!desc))
>> +		return -ENOMEM;
>>   
>>   	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
>> -		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
>> +		err = iser_fast_reg_mr(task, mem, &desc->rsc, reg);
>>   		if (unlikely(err))
>>   			goto err_reg;
>>   	} else {
>> @@ -372,11 +361,12 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
>>   		desc->sig_protected = true;
>>   	}
>>   
>> +	reg->mem_h = desc;
>> +
>>   	return 0;
>>   
>>   err_reg:
>> -	if (desc)
>> -		iser_reg_desc_put_fr(ib_conn, desc);
>> +	iser_reg_desc_put_fr(ib_conn, desc);
>>   
>>   	return err;
>>   }
>> -- 
>> 2.18.1
>>
