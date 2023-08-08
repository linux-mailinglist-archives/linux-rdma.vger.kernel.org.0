Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2116C773E00
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjHHQZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjHHQXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 12:23:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0819DA5D5;
        Tue,  8 Aug 2023 08:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFVJ/PJj0mzAKx3ZhMSAkQarkrr8zS2UthbUiIfuat0fofATmoNNA+EHkCbgYCFMk3AIQnBN2jPrStdZOXXGF8Vga8Su6i4SBkqHjTJeKoJn0qG4Hy/F4CGQlZeEtm8Vj/4kDTIn5H1bSeud2A4KtoSjZP7z4K+W1chpP6eSxpvvg2yMQDlvAzSoZTbROImjUt8i5FjfmJIInLV+DnI09/K/Uqx0psq1NL89s6Tnh1EzVqL2baFka72/p3dGM3XnLZtyJR8CuAbXHfNzl+40W/xx8AZMvnvMxLOsdGsxYNHNxa2NRCsU767wylKFDfEZ5StzcQqZy54+OxTl9NXx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaZ8kdL2DH/R1TC+obkBOuo0JpRLQmhtmZ9fGfd6LP8=;
 b=j/u2hfbOlV9ou3oWwHThXizxvGF4BXoNG9AJlr9CF5rUZIuT+x7T/dJX7CRul4u/O8M7s3wqWG3CygvDLHlEH2Cih3Pz1Vw0tSpVALSWQm6688kqwd0QZPXtMpUC2UmJt0JV/Ow+kuRt2TQpqeFDFre3K8r6wC6snOAjARUUGYYbS+w9LgIMajnIfopb6zD7HoIQ/W2d56W7uhqHSjq+WqVLlxQOo4uP+ef2DMNaRqQrkvJXASi/KYSyWfW096wey6Cmgw7WTUh5gzVkVCk286ivCyFlPnkvVEK0K1y3Ew26UzBQD5Ebs9B0scQPCJRE0kqmm8lTSZpKlA/P/MNNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaZ8kdL2DH/R1TC+obkBOuo0JpRLQmhtmZ9fGfd6LP8=;
 b=uIeUaHoD4rIXq+rFQZrr8vDV+YsI1jeF9fRzkoMatWsNuxpXjD33ONUW+XpXXUlrpaZju7S+oN/9pjdCTDhrwgYGiAVyi8/oOfyhCBpkXBGHDsLytvWbUXBHa2o1VcwIJ46GMb7ml5CdFdYIpyWBpa40ub5n2FOBUi+C80xFWbtnOenz61HRixeFtqz1xrJIzac1ERDQv4nYhZcn16b+ajoHcOizVAm/+KZpY0XOtGimA8jgtXPsYeemchyJb39dlHGIsPBliAJfgSloE80IS3IZqH4B5Q70zKi9+EyveiPGDSWxTNV2Xi00ofBVckUWmHZPlcI0G3m9HOgIUUo6Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PR3PR04MB7403.eurprd04.prod.outlook.com
 (2603:10a6:102:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:13:05 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:13:05 +0000
Message-ID: <4e1e380d-4d36-7d02-618d-0298f5e62ff6@suse.com>
Date:   Tue, 8 Aug 2023 14:13:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-4-petr.pavlu@suse.com>
 <72a98e55-46b0-66d6-b4b3-4f6d14e1fd7b@linux.dev>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <72a98e55-46b0-66d6-b4b3-4f6d14e1fd7b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0094.eurprd09.prod.outlook.com
 (2603:10a6:803:78::17) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PR3PR04MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e6ca64-ca95-48f3-490b-08db9808d1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kgU24+ikETaVg3WicHn8Y2+CNdfxxqRo0ZrmkOx9mm3fnTnRQUAqVI+Y0RL7MPnLdbv0NzED40QqGuTG68rzOIPhlQW5EoWhdfHTx8KSN3nsqp1ymcQiZ0TNhCN2mkjR+6HX0aYncm7yoIpShkwTWzUZ1Fl453jebEZ/ZpD/O3pD1Ys56AtO1TfUC6vpzhFGSHNiQSi3s9GMBLxOYqZlKSuYRLh2IF8OAyUbY1VC+x30IFUdzWy5j12gAZCTmROTIVyqRnyavM3GAh9eD9FUctV1LvC3JLQV4tJgx97mLWzuFo/FNwIuP3XF1M6iSIhqBGvtwfLF+jhYHmfRsAONfPJQMy7Mmykb2US0p5LxaGhY5Zsdg557DIwYm8hJ433soMZHaZF/r13BMVc+BMfTSdcG71Ss+ZugXpwJiZUBAAD9MPzA8EKlF7V7iHdn1+qj4KLABeNn/LzDeH6q74Xw91xRsZoxBsAW7BTMIjBJYkAtIAJBRA5OmCz0qbHyI3anbyxGWfZ1H7VeFA6e32EnbtOpzM+3/1yiNDJcNMIc8tLsXgeN1l3vGe/DjwKyrB4C5dTBbokyjyIpfaT0jzjhdgamO2cmoutWVeIeYzaFDVjr3PhgzflVBc1O3sewRRjxkbuu1JXs2CwvHxqzKUIQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(1800799003)(186006)(44832011)(7416002)(8676002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6512007)(6666004)(6486002)(2616005)(26005)(6506007)(53546011)(55236004)(36756003)(66556008)(66476007)(66946007)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJLeEVOeVJydXR4aFBER2dYdW9UVndCY2ZtZEUvQWNQemhUSmxwNFUyemhq?=
 =?utf-8?B?UnJsYVhPVmd5cGtnSEJNakVEcFlVQ1FpSVVDOUt2MDErZGxvQm1CNTRQd1Ft?=
 =?utf-8?B?WVpvWFB2emFVNnVPSmE3MUN4Z1E0ZWlTQ09DcGNVK3ZlbWsvbTlUYm5Tb2Vi?=
 =?utf-8?B?ajZLc0todzVHMHk2Kys5ei9UaTA4aTVXREZpci9abi9NTm5mVHprcHhqbDR0?=
 =?utf-8?B?NXBVRGpnVEIrWEhzbG5YbUJxeWtGR3dIRXNkQm1sb3J6QldKOWlqb1gyVVpm?=
 =?utf-8?B?SGdMTUgyUmJiZDhrNVliSzZwUnlCSTZjZUoxRTYxNHZEdHNtQitDeUQzbHhR?=
 =?utf-8?B?ejhMczhKRmpXaTZycmF2M1JhMnJwb3FmUEdmaDRHL2tGOFpqR0NpeDl5UEZX?=
 =?utf-8?B?Y1VRaHc1d3VQblBLNTZNMEE5dFF3OFFtSDhiMG12VzNUZlIzUklibS9mUlJP?=
 =?utf-8?B?THVuQlNWa0sySWY3QktmbHcwT1dqMW5BWnVxcEdnNzJoKzNVNXZBRjJ1UVdt?=
 =?utf-8?B?M3BHaDVJallKWlpBYllRdkhUSkxJVjlnT0RON1JKTURHdlFFb1ZpK1NVWGRO?=
 =?utf-8?B?NWlHTWVlWFlWbDgyUEZOWHRRaEx6SW9sS0RFU0ZjRm16Y0psOFdma2NYQnVt?=
 =?utf-8?B?K2Uyc0ZQNVFGL2NPK2wwZS9rd2VnQ2prcW9oYTJ4dHRqb3pRZXVrNXZjNmQ2?=
 =?utf-8?B?WURlekJDOXdQQWZqQXRaeURKNGVKOTk0dTdxMCtWUDlma2pqNGNZUnpGbHI3?=
 =?utf-8?B?ZVRpS0JpUk9vdVN1ZzlZaHIyRzV3SkRMdzFxMnlLOUFlaDczZVNndlFmcUdP?=
 =?utf-8?B?cjJXNkJUbjlMTjRZaWRoeXFxNzgrUDQ3RElhMGJwSGtQTDgyYitWcTlObUIx?=
 =?utf-8?B?L2UwdHpBazBjbXJJZTNQSnpienlkVm1tZkx2OXFGSGlCRW96dU0vOFIzNTVz?=
 =?utf-8?B?QzVGdzIraVc2SkJ2VmNOUjZTV09rVmtJaDk1L3ZVK2VnME95S0dhVU5nSTFn?=
 =?utf-8?B?UTF5dnA1N3NocVFZdEJIeXI4d3orMzZZSkJXT01ESng1V2pDL2tSTzBYemlM?=
 =?utf-8?B?ajJaRDJ4VE9GRkJMT1NHU2srclVocmt4bWFHWmxJRXhGa3RZL3k3S2dIM3Vo?=
 =?utf-8?B?QXo2S3pNYmt0UGRNNjNVdDc5RFczdFlJT050YWlzU09NVy9xbXRJVEJ1Z1hJ?=
 =?utf-8?B?UXpEYkJIMUovNjNEakluU0VEU2kwRThOS0NLRUo3U3E5VGRZZnJqTDBvNXhZ?=
 =?utf-8?B?anc5UGdRbis0ekVIaU9wVkMrRkJFcFFIdzRVeUFsQ1RZWUw3NU5NMFFFczFB?=
 =?utf-8?B?TllPWGE2c05YSWpDM2NMTmNQNHpkNGNpNFp6b0ZqM21QMWNDNlNRaFdMUFov?=
 =?utf-8?B?eHN1a2ZBc2VTZjJFTHhoZFBkamJNaDAzelE1OE5rM1F1bGRlZFR1YXNrMlJu?=
 =?utf-8?B?Rno2akIxeXAwRlNzZU1LU3h6TVdvWjlNdmdlSnA4NUFYbHRxQXdyRkkrZ285?=
 =?utf-8?B?dnpWanEwWU5hQk5NY1VzbXo3MC9sNFFqbWRiS1RKSDdjSlo4U1NIWCt2cWI4?=
 =?utf-8?B?R1g2TWVtQk1MVURldnhjTEZzanpwUkdDcjdRUHN0Y1BCS2xaN2JUS0NSMis4?=
 =?utf-8?B?TDA2Ylp6UDg5akVjMVJrZk43ZXVKanZ4MWlJSkFNZmNUUDFHVUpjMXRBVVd6?=
 =?utf-8?B?MXVoK05vMmZUc256dVhtWlliNXc0eDlqUkFmRktQL1JKcVdDcFRzRHBEU1lY?=
 =?utf-8?B?dGF3eDVmSlFOc3UyeFlWU2JqYVVSaGsycWRpNHdzZ1Qra3dob1ZoNmdlL3g2?=
 =?utf-8?B?NW5GQ0tjSTlyenpqcGRPRXpIN0ppTkpTb2JzTjBaaFl0V2U4eDJMM1ZDS1Bz?=
 =?utf-8?B?SVBGYlhGTUpQOTRueEtTS25Pdkh6QXhUaElwM2lmOHUxQXZtS2k0N256Sklk?=
 =?utf-8?B?RTNuRjFEQ1hxc2Z2TEVJRjhWYkZrKzRFRlMvQUNxV2NWUzM0TUUrWHQ3eHhu?=
 =?utf-8?B?UU9GWW9PVGIxTjEyM2Y5UGVhalkwMFNTS050b1JJcEFkNUhKNGZxM214OWVz?=
 =?utf-8?B?TkFKZHlNdHA5R0RKYmhYSVpkcmZpY0RSNFZUMGVveTJtWmNlblFVVFhqWTRn?=
 =?utf-8?Q?0iG+zkHPvwyxfvMnBo2d8aDEq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e6ca64-ca95-48f3-490b-08db9808d1d4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:13:05.1905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAyIIlCdDEF4WAqBNx3khivA0Wf6++MxZrI+fux5UkEneiPTD/qMg2O53T5P0QcZ7qLIyb3BXzX6s69QwEA+qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/5/23 16:29, Zhu Yanjun wrote:
> 在 2023/8/4 23:05, Petr Pavlu 写道:
>> Use a notifier to implement mlx4_dispatch_event() in preparation to
>> switch mlx4_en and mlx4_ib to be an auxiliary device.
>>
>> A problem is that if the mlx4_interface.event callback was replaced with
>> something as mlx4_adrv.event then the implementation of
>> mlx4_dispatch_event() would need to acquire a lock on a given device
>> before executing this callback. That is necessary because otherwise
>> there is no guarantee that the associated driver cannot get unbound when
>> the callback is running. However, taking this lock is not possible
>> because mlx4_dispatch_event() can be invoked from the hardirq context.
>> Using an atomic notifier allows the driver to accurately record when it
>> wants to receive these events and solves this problem.
>>
>> A handler registration is done by both mlx4_en and mlx4_ib at the end of
>> their mlx4_interface.add callback. This matches the current situation
>> when mlx4_add_device() would enable events for a given device
>> immediately after this callback, by adding the device on the
>> mlx4_priv.list.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> Tested-by: Leon Romanovsky <leon@kernel.org>
>> ---
>>   drivers/infiniband/hw/mlx4/main.c            | 41 +++++++++++++-------
>>   drivers/infiniband/hw/mlx4/mlx4_ib.h         |  2 +
>>   drivers/net/ethernet/mellanox/mlx4/en_main.c | 25 ++++++++----
>>   drivers/net/ethernet/mellanox/mlx4/intf.c    | 24 ++++++++----
>>   drivers/net/ethernet/mellanox/mlx4/main.c    |  2 +
>>   drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +
>>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  2 +
>>   include/linux/mlx4/driver.h                  |  8 +++-
>>   8 files changed, 76 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
>> index 7dd70d778b6b..458b4b11dffa 100644
>> --- a/drivers/infiniband/hw/mlx4/main.c
>> +++ b/drivers/infiniband/hw/mlx4/main.c
>> @@ -82,6 +82,8 @@ static const char mlx4_ib_version[] =
>>   static void do_slave_init(struct mlx4_ib_dev *ibdev, int slave, int do_init);
>>   static enum rdma_link_layer mlx4_ib_port_link_layer(struct ib_device *device,
>>   						    u32 port_num);
>> +static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
>> +			 void *ptr);
>>   
>>   static struct workqueue_struct *wq;
>>   
>> @@ -2836,6 +2838,12 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
>>   				do_slave_init(ibdev, j, 1);
>>   		}
>>   	}
>> +
>> +	/* register mlx4 core notifier */
>> +	ibdev->mlx_nb.notifier_call = mlx4_ib_event;
>> +	err = mlx4_register_event_notifier(dev, &ibdev->mlx_nb);
>> +	WARN(err, "failed to register mlx4 event notifier (%d)", err);
>> +
>>   	return ibdev;
>>   
>>   err_notif:
>> @@ -2953,6 +2961,8 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
>>   	int p;
>>   	int i;
>>   
>> +	mlx4_unregister_event_notifier(dev, &ibdev->mlx_nb);
>> +
>>   	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_IB)
>>   		devlink_port_type_clear(mlx4_get_devlink_port(dev, i));
>>   	ibdev->ib_active = false;
>> @@ -3173,11 +3183,14 @@ void mlx4_sched_ib_sl2vl_update_work(struct mlx4_ib_dev *ibdev,
>>   	}
>>   }
>>   
>> -static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
>> -			  enum mlx4_dev_event event, unsigned long param)
>> +static int mlx4_ib_event(struct notifier_block *this,
>> +			 unsigned long event /*mlx4_dev_event*/, void *ptr)
> 
> /*mlx4_dev_event*/ should be removed?

The comment was meant to indicate the actual type of the event. I can
remove it.

Thanks,
Petr
