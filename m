Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EE7EEE50
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjKQJSx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 04:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQJSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 04:18:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD89B7;
        Fri, 17 Nov 2023 01:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700212729; x=1731748729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPx/Lw+9gYg7FCNJX/G1Knr2Do0lmoOLBEgiRUVt5wQ=;
  b=eatmJEeS96+hA4TXXuesup3QsD6b4R0oAMuX8vcTtDPAC7nQNjpxpacg
   ZktGbkLmuKCDHcOSdhLTseyKZd1F4G5NCP3dCt7ZXLmnkvo0SSLzfBdu5
   rQ4qi/aaaNUP1LcEaxr22rY/FIt98mFSt9ZtY2GCe2ifKAfBTXmo8xEG3
   eMrkAZR1bfzANt0bhfu2MGVuYrAE4ItUG5qzrzGmyRIgaNnikqQ583ZTo
   MHrmxM2Qn7clfElu8Vc1FlHH3a+kwkR8Tp+QZuAZH9b4jRlHblaaID16z
   TZMRgEfdVKVy1HFiQ4QI869dmzdDtpfkCMakigwnNVuNkA2QaT0Aa4zZR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395192904"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="395192904"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 01:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769176456"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769176456"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 01:18:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 01:18:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 01:18:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 01:18:47 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 01:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTFj/douqR0C1+/QEtYzocPTSgtvpVnd9oEjXUSN/TjQDTpZNSQ6H75EQ2SeutvjFjWQ72EqWEha2Pzev6wRT/17GHAotKBtuOuFH/02l+NH6/gUdsi9FGnBUi+0h+hyxLTaGe3JsHWX0P/Zp48VCVjyMfQPTyP+89TZhY+6cHezXrfedY5su47DHScAEFZoqpgufw0vy+6at4B5xUejPbyqG9UGRMtQQYP44h2xcynnHHy7bJx1Fw1C5pUMYOri6WZYkB4DImK+Y1rjDlUd245T582JkuC+XKpXlsQZSezwoPUGmlLTfYWiUj/GbrTiX3wJdXNsK6J28hiM4bf5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUfyRvQp7kX1BkDX1OGmkLQpNf+B2N4Lk7CuU61QFoA=;
 b=ZCBVcLpvbOn0N1KR/Vdsgb/QQOpmgbAAt76su1qzdMkZyMBLg8tjEMIKfVIFCYuaPb0K9z7otbrd9iT0JkAgrRy+RaiO7MXk/71kUHubTO07uHH/qqOwnCVHnLmmqHc70PbWV5jPLWEmnwnA40oJaoZFMPfXyOBoXfPODoRvmjndQ0B7JWew7FogoFERURQ0DvCi8LSfZJM+aZfR/yL0MBKqVwHOGpDI29SzJk+VoB3o4CcKN+/kR2nEQacvxr7s1FoQrfki/NGqx5wNxjIF4VESm5T9gQDXHvblO1U8XezqTriumbSJAYCk1A073++/fjdmPzZwhdyk6mZVo8YIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 09:18:45 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 09:18:45 +0000
Message-ID: <5165bc9f-4e57-bdda-0640-d6cdcd08f031@intel.com>
Date:   Fri, 17 Nov 2023 10:18:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] net/mlx5: DR, Use swap() instead of open coding it
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <saeedm@nvidia.com>
CC:     <leon@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ2PR11MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 287484ea-cb33-45de-ead7-08dbe74e32f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2F/Do1NYHgQbTFXIBVG9hCDZfjMgtyIjVshW1ebfPQCmuoSGLGtscVvM8EHmAPybAtDxd3DL692HnYcxMueMYapssCmhk2Rvm3uo7n0nYjdvXUtwRR4zPMYa9ASrWoQj0pvAx9PjvDSGlDW9Tz80ZmEXquwfKAYW3aSKveGIZmY7+Pz110Boda0oRHvtBLLXntvLuF57fQSJ+mIn/Ipw/vaLlL/zws5s/WIqqtOIjF03X/vFypyNgJ4Y4R537lJxOoJr4zJrGrbr0D5HoPbzQu/EvNXcPSjkE5Snj2Tm1RniywbWJsmMRO6njOCOvqxCWBRQ/nDlyuLWrfOUEXeEuen8AzZs5QHWxxS5+HGxkQtLd5NiKSpfjjwvqgwSV3Wtf6+B80JLGt3l87OOjeSL2KY9JDftMND/Gs7GH3O09sqEngihUCgkb24dcM/QPKiUvrQFrSBwfQcGtJVArziIK3n6eBrpAOnsJygzT5oKRylfnbVw550TLB0Ev3zw2Htbg2Hgy34Fm89U8ehxQ5vfO1glxLk3HV2SGe8Gwj1cJ/4fRVQT52yAk0FrflXPJtnXRmMfB57obugLjOitLnlmlOOtqSW1rsbez4ldYc4P4qvDUSa6/Arzsrp22XtG5FP3IA5FlWmkBCJATtNdyjDojaQZjq3e4D1blFFLQWeKXvJ/WF3RpPWTIWEyw4YoCfQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(36756003)(26005)(6512007)(6666004)(53546011)(2616005)(83380400001)(5660300002)(8936002)(8676002)(41300700001)(7416002)(478600001)(4326008)(966005)(2906002)(6486002)(316002)(66476007)(66556008)(82960400001)(66946007)(86362001)(38100700002)(6506007)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFAzTUI1UEFFcTFwZU41YXF0ZERHeU96djZzVjJGN01iNUd6OXlLOWZPSHVZ?=
 =?utf-8?B?ZlkxQmljSG1HejExZk9SMk1OS2RGMGN5MjRlRHJsazhkMlZLU0pZaXhyMUk2?=
 =?utf-8?B?U0JlenB5c2tFT2F1d0M1SklhNHVCSjc3R3NGVUNlZStSaEVUd2ZyanZ0TWJE?=
 =?utf-8?B?eE9YVS9Ld3ZwbEtGMlJKMjRxc011ejFKQ082WnQxdHFUMzJkQkRaMSt2cXc5?=
 =?utf-8?B?c1hPY1k4OEVYenJySzBmVnNRQXFhN2VTT1hTdzFiSHN6SWxmaEQvYnJMWmI2?=
 =?utf-8?B?NzJWV0R2YUIzVS9UNEdIa2lQaTBOa2I5TFg0NkhLbDJVMCtTRGhyVmdMREpj?=
 =?utf-8?B?d2EzWklKbU55QlRDZkkrZncyVGJLWUgrTFRaaldmVlpITXpQdEdkTlViVDZz?=
 =?utf-8?B?ejd3NW9RNityUG1DYVA2aGFiZ2M5MkZCRFJIaTJuYzRGNG1BWUl2NW9HRlFD?=
 =?utf-8?B?OWpTODFTSGo1Z21La1lSVEdBZHY1NUZ5T09WVjZLM0t0eGV2cWs0N1BjM2ND?=
 =?utf-8?B?bjJ1dHpQYU5BT3hPaGdiVWw2Zm1XdzBncHRzVHdqNTl6RUd2cTc0UDRXQTdY?=
 =?utf-8?B?ZmIrdTFCWmJuRVdPb2cwZFJCbWdKVjduc1pqdjQvK3E2ZUdqa1djOTRQMnZJ?=
 =?utf-8?B?cndyTy84Z2thakJmRXp5QXdSSHppdzlSb2dhdzhlR2U0T2tiT05IN0t4bkd4?=
 =?utf-8?B?VnFHTkw5L1E2RnhDTVhpZlp5MDA5NjlSeHRLMU5WVmo3N2FhMTVOUGgxOXFR?=
 =?utf-8?B?OWxnSENVdDd3cXNhQzFreG9sNVhjT0ozZlNRaU41NU52dkRuWE5NVTdrRXhU?=
 =?utf-8?B?RmNVVmk2S28yUVg3Qzdzdk5TajJhcytYMzRVMFRxdUVEQStjcm45ZmphQXlS?=
 =?utf-8?B?WllGSnY1NUdVQlpjejdveU9hQnpyQ0N5TkpCbXovZ0Fqc3FuMjFNZEx1R3lh?=
 =?utf-8?B?bU5mSXoyYmNyZ0tyeUJXMEx1V0R1ZGVGaHNscjNqaWJJOGZWMkc1SlZ3UWpv?=
 =?utf-8?B?c2FQSlVjdDhrV3NEak41VEpZeHlFeVoyd24xdjJHcnZOSXVZSXZDbzBlUjFJ?=
 =?utf-8?B?UHRsaDF0blFHWkJtRytDMjE4eHRBd3ZuTXh5UUt2SkVGbS9vTXpHWGM5djFB?=
 =?utf-8?B?V2NIcmF5QXFLY1NNNGJnU1ZHZ2p6NGV6SzFsTzhMekdmQ0FUSEZNRnd0NlRM?=
 =?utf-8?B?NlhaZGJGS2FtVk5CV0JzL1RJWkd2K0VCZ0RtVVIyYVNrcmRJUVFNM1BhUklj?=
 =?utf-8?B?bVJ1YVhCcjIzdG9QNHFFYWZPSWdLeTlwQVBTMXdNVE1ReHRBckZId1YxbmF2?=
 =?utf-8?B?SUhjeVFac1RqcGE5L3ZJc3g3RjZMZjVWS0dzZWFrUytjc3BObVlsUUQybjlv?=
 =?utf-8?B?QlFEWjl6bmhTYUhJejFLOUxZWnhKVkVNcCtnOEMwZ3p4dGVEdUV4OHlocExs?=
 =?utf-8?B?bGdLK0h2bWVvbk1PL2JwOXhWdkhrNU1RbUNNbmN5K2dmTXgxV3JBQWFDVW1H?=
 =?utf-8?B?SjNnL2JqVHF6amFENG1vOE5Ic0IvRU8xdDMvQ3lXYmJ1MUNQbnJ2RXNqdVRW?=
 =?utf-8?B?VCsrdXE4OHNXbWp2NHdPaHZuZ0V6UDQ5SkdGRkFCNXB2TjJQWkVwamhwemlU?=
 =?utf-8?B?SWdpcGswSnhWWGxBaGhZbUJsZks3cWc0UXV0VTV3NFFvQUVWRGFmcU1BZ1lB?=
 =?utf-8?B?U2hXaU1WRGFlaHRYK00vTnVtY3l4SU5vd2ZkR1dOenRWNElhMHRMTXRXOWYz?=
 =?utf-8?B?WTdaOFppVUNYcHd3SER2Qm5kNDJoTExCNGxaM2duSVBqNFM2Y1hWTmJnVnJy?=
 =?utf-8?B?SDMwajNYSitkeU9veEtIcGJwZzRmUkpYZDJLZXlZU1duSUZRV21TV2k1WUNo?=
 =?utf-8?B?VmZZVFhQMDhuckN1MG90UXdpc0VHUmVLVWJyR1RGNENsUHBoaEZaWmYwZmFD?=
 =?utf-8?B?bkk4SmVNVjduYVZjdXdMNXVPT1pUbGJUeXdhMllJbkR2TlFCamd4Z0lrNm1C?=
 =?utf-8?B?cGlBWjFNSUY5SDFzSmcvU3Zad0pzZWRyUGUzT2J3VzVZMmxYNzN5RUl6M3lY?=
 =?utf-8?B?eTRKQ1BwTk5JY1orejI1UFVuajhnQUV4MFVBRjh3amxMbkJFU2ZJMWhwSStP?=
 =?utf-8?B?SExOMkRmbytRME5KTk1lMVQzNUdpb1M3T3dWaTZZU1hiZ2JyVVYrUTQra3pK?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 287484ea-cb33-45de-ead7-08dbe74e32f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 09:18:45.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51DRUVt/6EMRDJhrV+ZbSRfYXiQUMdKDOTadkYsBEt7mApFDzAM16KsxqrG1IfDuMhbLaDXu3tuj7jcIiGqjybW6KT1rsjY4Sibhqbz9gts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/17/23 08:19, Jiapeng Chong wrote:
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/dr_action.c  | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
> index e3ec559369fa..6f9790e97fed 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
> @@ -1170,7 +1170,6 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
>   				   bool ignore_flow_level,
>   				   u32 flow_source)
>   {
> -	struct mlx5dr_cmd_flow_destination_hw_info tmp_hw_dest;
>   	struct mlx5dr_cmd_flow_destination_hw_info *hw_dests;
>   	struct mlx5dr_action **ref_actions;
>   	struct mlx5dr_action *action;
> @@ -1249,11 +1248,8 @@ mlx5dr_action_create_mult_dest_tbl(struct mlx5dr_domain *dmn,
>   	 * one that done in the TX.
>   	 * So, if one of the ft target is wire, put it at the end of the dest list.
>   	 */
> -	if (is_ft_wire && num_dst_ft > 1) {
> -		tmp_hw_dest = hw_dests[last_dest];
> -		hw_dests[last_dest] = hw_dests[num_of_dests - 1];
> -		hw_dests[num_of_dests - 1] = tmp_hw_dest;
> -	}
> +	if (is_ft_wire && num_dst_ft > 1)
> +		swap(hw_dests[last_dest], hw_dests[num_of_dests - 1]);
>   
>   	action = dr_action_create_generic(DR_ACTION_TYP_FT);
>   	if (!action)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

For future non-bugfix contributions please target patches to net-next
