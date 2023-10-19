Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF97CF926
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjJSMk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjJSMk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 08:40:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AF91;
        Thu, 19 Oct 2023 05:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A72gcsx0t3NWGh0j3bvPjNZ95v8q7fcXhGXVmC10l3WxeWGsznPyThGdXQ+3R22nw59L1WfZJvX62kxQgteNxEQ9PYH8KT6dHO1J07/IQLxZ+ycKKUgvI0PyeXVjtNoQ4jN329Bu68ZxiYqFwdEo2TBzNXE7mvTHmyWsSsHBlFCgtumkN2JnnU657ijoGMtlu1oGWEXJmuFcHL+yY+Vmf9TNToI83Wi/3jPIgWmi0IbdcOx4In0UKZPnhPzRQPA03/diRaFT+JwTAuTwQoRe2+wJIp1Rf4UcoaGU3MGH7KYt2WnqobJ4LRoG7ntZ8xvRL8sAuOYY2vBIyhwd1Nyp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hxce8Me082Fy+S1RS6zGbpFo7sO0CbpDsy211RNoqSE=;
 b=UGBXSt6QCqpC3hAicjJfqACRPveuChjVrTeF8CpZymt8q1rSd5GmLP4RvRYOk79tzBmcmkYvwUNueG7miafBYe+rE2wU7F/thaaSNzwMwJWC8qW2qAUKI1qdVEACl8GQ/9DjdCu531/Cx/WXc5U7PF9aVUeF0bFPrC0qX8OZaz+SykrbLURAATL0gxntugHbpp66GVvEoqn23fsfvehNjF88oIXlYoUMEa0fL8gEjOrlsPeZprr68EvZKMTIHZpZ603t0tz+H7u/jGVg2NhIQjsW05V4xddHXMPOqCwM//sfEBhxOMlJBzfhbTm67uBHBM6YuIQ4JI/U4SNOjXuIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxce8Me082Fy+S1RS6zGbpFo7sO0CbpDsy211RNoqSE=;
 b=UMMn/ieWJcu0K4IKvs/oFsLPItVujS+36pLdSKOuo0sqCsCw0CssVgoxdgiy3WJWwNq3RXQT8L+PwKHzUB/1eSoUJkath2mY++5CTOoFByOkfGI+uojuc3BTni9pd5UznGnq+fwc1XveSoV9D0Xdf5Zs2T9eAjuPFDxX6WuMx5c2u/asvQsMC8kJsZxvId6Z91UGfDKpJqw1384x1vMJMKBO9VFOUbBunhfR7cgaW6IobXDRzrdOPlXmRGQ7DjEe2ImKQ7jzKGWnusFkFN87kC1NgYpCtt5+bohiy5TswPubxAe31Nvdn6ritvPKhst5q/oevqaPESlpuR/q6wIWXA==
Received: from BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 12:40:22 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c1) by BL1PR13CA0367.outlook.office365.com
 (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Thu, 19 Oct 2023 12:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 12:40:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 05:40:06 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 05:40:03 -0700
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Petr Machata <petrm@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
Date:   Thu, 19 Oct 2023 12:38:10 +0200
In-Reply-To: <20231019082138.18889-3-phaddad@nvidia.com>
Message-ID: <87il72aiqm.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: d11392f9-e05e-4111-e6cc-08dbd0a08ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB5Ih2z4xNXwT5KM0DD/eYKjldeyLxDafbzpAheed5UGHkbTdknPxJfgeYn2q/Vrx4qFUxarHl77PvYx9oEC3sSG4D0Y08PrnSSbjzqi0bTFEuy4GgkesMreT8dAPizGrZCbuMSpbvJaWTEUbrMW4YYQGh5cPRhtra0HT4WBzc7xw1Pxvns8oEn4L6qEn0CKutfScXEU4LRze9dZAhCJ5hps7prthxjMfPXhcqLLqglkjeovgKF3xXiaP+3It+C00Y2ahDmH71t+r7eUckzSlGGlsAodiRiDo/BTl47UB20UDkgedYMz5cDzSRZYThxMRQv6TKVHPLDXl55qPG0SKh/HGCFjTgEHNjkpGbNW3nMXQmIcyT7RLZxgeJxuaCPJZUqh/ZH1eZcVGL+U6kkb3svyiXoUIXq3Nr1bu64cn5kIsJeBzyMmpF3+P2JIKdwp3wyjJsvw0cCf2Rtf8weQTXyC+ZK2b+Tx2QY1moRVyhIXFh5aZR4mI+Zcvh6IoNzeFysSAuCClNl6IsdbQNOPqpCA8jYwLmOTyOz18dbOk3Zru1TBgdbewjQxumI+Kq48aTppQOgV1A+3fsMS05SUZXPkaP0UT4TGDdzp+fBjCTpGZ0jvGLlMYSCA/DFf2my1xMkaPwS9Om5Ng5RYHvrYTDG+fLY6cWNdEthz0PEbLGWvDSaUOMoIZgmeMaQXb3wUKA0F1jRbOEDCWe7hK+oK1VQ+QyEk2e7CzF/A2tTIzbQ1eU7dg2TBsuvsYIWKPl+7
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(47076005)(36756003)(6862004)(41300700001)(5660300002)(4326008)(2906002)(82740400003)(40480700001)(356005)(26005)(16526019)(7636003)(336012)(426003)(36860700001)(107886003)(2616005)(6666004)(478600001)(8936002)(8676002)(70206006)(70586007)(37006003)(316002)(6636002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:40:20.9352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11392f9-e05e-4111-e6cc-08dbd0a08ec2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Patrisious Haddad <phaddad@nvidia.com> writes:

> @@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>  				   mode_str);
>  	}
>  
> +	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
> +		const char *pqkey_str;
> +		uint8_t pqkey_mode;
> +
> +		pqkey_mode =
> +			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
> +
> +		if (pqkey_mode < ARRAY_SIZE(privileged_qkey_str))
> +			pqkey_str = privileged_qkey_str[pqkey_mode];
> +		else
> +			pqkey_str = "unknown";
> +
> +		print_color_string(PRINT_ANY, COLOR_NONE, "privileged-qkey",
> +				   "privileged-qkey %s ", pqkey_str);
> +	}
> +

Elsewhere in the file, you just use print_color_on_off(), why not here?

>  	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>  		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>  

> @@ -111,10 +155,25 @@ static int sys_set_netns_args(struct rd *rd)
>  	return sys_set_netns_cmd(rd, cmd);
>  }
>  
> +static int sys_set_privileged_qkey_args(struct rd *rd)
> +{
> +	bool cmd;
> +
> +	if (rd_no_arg(rd) || !sys_valid_privileged_qkey_cmd(rd_argv(rd))) {
> +		pr_err("valid options are: { on | off }\n");
> +		return -EINVAL;
> +	}

This could use parse_on_off().

> +
> +	cmd = (strcmp(rd_argv(rd), "on") == 0) ? true : false;
> +
> +	return sys_set_privileged_qkey_cmd(rd, cmd);
> +}
> +
>  static int sys_set_help(struct rd *rd)
>  {
>  	pr_out("Usage: %s system set [PARAM] value\n", rd->filename);
>  	pr_out("            system set netns { shared | exclusive }\n");
> +	pr_out("            system set privileged-qkey { on | off }\n");
>  	return 0;
>  }
>  
> @@ -124,6 +183,7 @@ static int sys_set(struct rd *rd)
>  		{ NULL,			sys_set_help },
>  		{ "help",		sys_set_help },
>  		{ "netns",		sys_set_netns_args},
> +		{ "privileged-qkey",	sys_set_privileged_qkey_args},
>  		{ 0 }
>  	};

The rest of the code looks sane to me, but I'm not familiar with the
feature.
