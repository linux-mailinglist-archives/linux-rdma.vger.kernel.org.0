Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD87D650F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJYI3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYI3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 04:29:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD14B0;
        Wed, 25 Oct 2023 01:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRmxjLr72sbuuBbfOSuCGIKwVlrTQMJP8v9/ppiDCvjpQ+StoYGEoQdJuDp/aa7yLct1KAoyeUqOOqSGrrWH+EYlj8r0KWQppOztXvtjZlIc6PIsqUd72wbWIp22AOb7uKabJK2l89ahRF9FM2tUBgTus0pOiCrN0EyjRSNbXBjAXpHuX/zIgI77mCSu9oRsX4pIgI2OILMk+/s8y6zoJ7nrHohuF6Bvim2MJ3d9aSgSK0r3864k2XCKyC32Al/KUhpa/gTw1lJR1NDItY7XNE5T80aAjaikcbgEufbf7tSQ6T/JFO6TJCenK6fzcIE2pFFY+aazJoUYc+PWBV1ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0mjhQQ/MExX6w70WmvmHVVBDLh++Lgb/UEv6wZxFNU=;
 b=CBCpASEx0TR7jS/YSFQQjmon97F90jZqkzfYlQlu5MjR74E2i0oWlcUY5o2Nsa1FZq5hvKFx7o5sT2EHTNinhW2kwtTRoJVxQfGijJqnDTF8v2wr4FJNzaXYhjyyzOIdB7lhMNlZW+Ve3OzxYOOEJHJpf+oZDmbN9cTp9W2t3Ers+0h0wVt9FILubKSpXoZjEhmvQA7soAol2i4n1AjLYWu5xs38TOlF+zBvLaIREU6CcEHpax7mUa8KhqgVS9WYcfdWprjdBkergc24DnT5oBRyMfD+kCAz5XszUQv2XxPUZm7Fl5p/1glQySGMUan/2irs+6WzAJXJ47yaltKfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0mjhQQ/MExX6w70WmvmHVVBDLh++Lgb/UEv6wZxFNU=;
 b=WkLV7qScW1aOZhO+qdtQy1Bv2Y+jE/j9i12oIaHC/Lmtb8BI2ZeIYmf44cng5JlS7DxawPTV8+gOLfFjzUHWLxkH5TpOM1Cxhhpwuw6PbGQRVUdp/2Qd7cTnCIh4F4e4JJmDD6ZSDBB61+436f+9hkSsfkf5S/qS5RDxyLn5mJThCfDC2mMS+2bjAslARjj3s1pEoN6QnNJJ72iQQYQO/hJjCjwc2mzE4pcFunfMFJ89Iv4hUsH/zeCVkTSaM16mJKZIRwRhvWgLbEw39D76cnwidf+oWeO+XsC5sYUhdFgmD7LvKd45wpNsiQZvXMD21NJ20sub9OGhl7aAiRNgWQ==
Received: from SA0PR11CA0164.namprd11.prod.outlook.com (2603:10b6:806:1bb::19)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 25 Oct
 2023 08:29:30 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::bf) by SA0PR11CA0164.outlook.office365.com
 (2603:10b6:806:1bb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 08:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 08:29:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 01:29:04 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 01:29:01 -0700
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-3-phaddad@nvidia.com>
 <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Petr Machata <petrm@nvidia.com>
To:     David Ahern <dsahern@gmail.com>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <stephen@networkplumber.org>,
        <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <huangjunxian6@hisilicon.com>, <michaelgur@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set
 privileged QKEY parameter
Date:   Wed, 25 Oct 2023 10:25:53 +0200
In-Reply-To: <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
Message-ID: <87v8av5cmt.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b881fd2-5278-413d-db39-08dbd53481f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSnsL7So0XC3c0X1WJ+UXsjuRqLHVJ7CrFaQJr+So+avEL7cwQ16Nvq72T38Jd09JhHmTS8vT9EEnl6/ym7T3n0nhlN48YM2KYdYoSTR4yJ5RPshh0ejzrCXG7g36aT/WUTa8FRiMj5GSmQuOcT/U/c7J9uwHlJZ7CaQ4PmO3GTOPZ9mtz3pbrUeT07U+uIoKrQvtYtIQ5IEuBh0cBlV9O7W2EmQl7J1XZZM9iRTBuDO8TGooZHJUsU5n58XZSOGY7J+EJnuiPV9jLxHuJQxtHPRt1c2c0U0gESA5EqR2N3J0SpthXcpHDwLzOIGlVI05UEMWktTQicMreEc5xLZarDsBbJCsrhxwW5+sOXVJSbk96UwM/+5VP0+vT7sZSFtva0wnstIaBeX2KCM634f/DXFcYT/VkUY2bVuu4jdR2kbqXT3I/rBWmCVAR3KVGKf2EHT80sdooOmdm2C5E7G8VQaAHN++4o0IIsk1XhjOD4h0o3UWEp9v4akEmJEcb6lWC8CZJmsqT3S5lFkTKWf1BM9/zhB/3tG6+0Eudc1MMYa0+VZnWH4wNWxiQaxbR/yBDkyqi/5eXlIdAY53s8iBsMe5AQpoU0WK8sO3GsYdVoUm+kuddEC0P1joYBVYRke7mdbEe8eQCf5BCgsAlIYI1u3nd2gMWlYn6V6kCimfwosfEPtAMlDTg9O8G8+4gSbjTdCGbp+DJNn/dvk0QZrSgG3gxKIm1hHtQnIWRcJMuxm8CNwNi9IMf3KMy+5Qfc1
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(16526019)(53546011)(40460700003)(4326008)(426003)(26005)(107886003)(2616005)(82740400003)(8936002)(336012)(8676002)(83380400001)(5660300002)(47076005)(7636003)(40480700001)(356005)(2906002)(478600001)(86362001)(41300700001)(316002)(6666004)(36756003)(70206006)(70586007)(54906003)(36860700001)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:29:29.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b881fd2-5278-413d-db39-08dbd53481f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


David Ahern <dsahern@gmail.com> writes:

> On 10/23/23 5:22 AM, Patrisious Haddad wrote:
>> diff --git a/rdma/sys.c b/rdma/sys.c
>> index fd785b25..db34cb41 100644
>> --- a/rdma/sys.c
>> +++ b/rdma/sys.c
>> @@ -40,6 +40,17 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>>  				   mode_str);
>>  	}
>>  
>> +	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
>> +		uint8_t pqkey_mode;
>> +
>> +		pqkey_mode =
>> +			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
>
> just make it mode so it fits on one line.
>
> 40 characters for an attribute name .... I will never understand this
> fascination with writing a sentence for an attribute name.

Yeah, I noticed this after the review, and figured oh whatever. But this
would be better:

		int at = RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE;
		uint8_t pqkey_mode;

		pqkey_mode = mnl_attr_get_u8(tb[at]);
		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
				   "privileged-qkey %s ", pqkey_mode);

>> +
>> +		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>> +				   "privileged-qkey %s ", pqkey_mode);
>> +
>> +	}
>> +
>>  	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>  		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>  
>
> keep Petr's reviewed-by tag on the respin.

