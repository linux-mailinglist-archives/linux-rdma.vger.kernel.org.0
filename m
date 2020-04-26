Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB611B8F1E
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 12:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZKuP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 06:50:15 -0400
Received: from mail-eopbgr00043.outbound.protection.outlook.com ([40.107.0.43]:52318
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgDZKuO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 06:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOB0kIz5wkIzEZDV1deGNAZGM6AGJXi8f7mAYBxPdOiHoqAv6wR4ybDV0YS+8JbPgB1aO3LmPgymlIEWFBLWn+6/8TVb4RIukJFuB1v6KoRBBDLjuHll6GXVgd+0gLAVu4WwF2C4Sw5uLVAiGhSp5sqd3yzP5cy5Uv3K1AskypfPnoYbs3zaQ2yakGEtNNveKhKt46XTNPA7kegwTBQkBAjj7XB04s62sTeLs2+h6/uEZcj7/37bFBjVwkMk7wcrmZ6gMIAZM1o0gBkJXKOptyPPdPrWFwOQfwDrRnEpX7WtuY43BNsFvn1OTlMC13xqEmKegyHqWhUirRdSQWMXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Z4vqG8/wiFgPOkBS/B7XpedqHDRL8Ip9+gP48Y9U8=;
 b=aJMDkuPNtfdDCUztuUj1CMQEk/EiqAKIFo+sSe/jX4vFxG0tKKil74O686F69mXjYRt+23ui3VTHGQ0qQmaUppt/lxPZdeDFF6ToBtSt2Kqwr9CzZKdMI3h46HddsMYzyAuTtMmcPvSGjpYyh0XO/g85Qr7qYMJ5PKYgtCHhJVtU+X/Vyss3vjIyeKXdx2Q2QoyV5TzA9n53W6WJXRJseqhyn5s/YWniCD84AkIkmh449wXkYiUNET81f+1qXWgjil/LgXnHT9Ac6QIn7VGlVoV7a+LBbjHUiw37Y2jxWM+G+cGRugVUS5kC+4hdmCwozBgZADMSWpCj1oGNC3mDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Z4vqG8/wiFgPOkBS/B7XpedqHDRL8Ip9+gP48Y9U8=;
 b=g/cMvscY+K5SB5UN9Ik3yZ1KrhxZ/gQk64SSyOZivolZB3bbKVyfmrPovCMIJBcF64895TIOUq0qVm7P1/KSZmifPWBirXJOKLaI2mq0yf1RyrwXfGa50OQ7Hm0UPUSKXZw/rdcfI7XgRzL1ObDpy2QZlaSyFU+bKLLEH/03BQ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4244.eurprd05.prod.outlook.com (2603:10a6:208:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 10:50:10 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 10:50:09 +0000
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-16-maxg@mellanox.com> <20200421153045.GE10837@lst.de>
 <0c6caf5b-693b-74af-670e-7df9c7f9c829@mellanox.com>
 <20200424071433.GE24059@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <9da15ad2-ed9c-9a00-4781-b57712835b3b@mellanox.com>
Date:   Sun, 26 Apr 2020 13:50:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424071433.GE24059@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (217.132.59.243) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 10:50:08 +0000
X-Originating-IP: [217.132.59.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 639caa44-8f62-4630-5c8f-08d7e9cf96f6
X-MS-TrafficTypeDiagnostic: AM0PR05MB4244:|AM0PR05MB4244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB42444511A47C7B2F251C541BB6AE0@AM0PR05MB4244.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(53546011)(86362001)(6486002)(16526019)(8676002)(31686004)(4326008)(81156014)(52116002)(2906002)(956004)(6666004)(2616005)(8936002)(186003)(36756003)(66946007)(66476007)(478600001)(16576012)(107886003)(316002)(26005)(66556008)(31696002)(5660300002)(6916009);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gY9G2g4jvd7rN/q9CjO70aGdZPusenqUtrfyuh4ibQJf66l+pmEY0TWuLnh5FkY2gNImwwjrrjjmDZmdPfJZfnYoRG51jiPMD0pPATbUMWh5/aFZRwDbRPVskoRtiBb5W8V+mAD2ZniNOfBvwdc/8toWYBjVonz2PUKKRX3I/gQFyp3JBIc5qvqvYwy/ULw7TKZF929kdvo6xHik83uzsjKaA9LpVjZZXlGqGpvH32ZwmVVvawCa0zDEON7meC1wyd2+ocLYgunNyhTVECaixTxhHJV6AKlu4LNFcLPLbMKsNz7GyPJMTdT7tWduAGguelnN5q03rG2W9c8+Oz95qEVl0JdlQFLddqDKqLqKkfJhVWTdzkzWJGR4WP4QDg8dOYRPcYkYBTKlz8CBC+xzdZr+MwLbCdW1MSpm3MKWGZq2Ij6wtUWfeO07YMR4sSC7
X-MS-Exchange-AntiSpam-MessageData: StMVGyRknFr8T9dyEGPlU+TUI8p1EV55HLO5SFNri3BSrFc/aWJ4T/ZRPK11phgX4gcLhpbSCVdG9DCTqq7zLTZpsem38+KjNSaX3oV92je4gkwK4PmoGiQmOc6xt9Th2ZN99jC9LPkSXFLD2mG33Eyd7NNth3khRvTHYaidEmcTTuxzGqvQMvWPcOi/eetEzNSEA6uss7n6ICGMLonYaRyXYWYm54LnDLW3mpRa15yfPhdPUX3608tcoQQ3p5+ZL6UhWCqj1F4Om4lgkF6XDRVaiwh8rS5ij1fuBGv/Es4LdJWTQbYPz+XJlAZMf9qpLtOu8WyfpCVUpMNnGcwLo88+QCDkV/q9pnkvNmFbSgvzKhPVhfGTzKx0f4Mn3+aygGRypglz5BKE7MzQiyGiWLaMqRfv7r3owMayV1JVB4QtCBAIPfKzbE92s4LT2C2PQcV3PYNwd7uopILHhP+JPMzPWDzUpcZiGD8WcpTL6vJEZbhIcz60p7IE7CeFuriltLckovTv3RB5I0Ab959ORYZ2CllpYLcp7uxTT5eZiY4htwNFt98p9115tVnWGv9DLn4T/kbEUS8Px8udQeKVZhoh2FmkOCtXd8qhhqFOoGwfU2q/2nSUrUi9nZGcyvU2BvfqxjqCi0JJFNanzIri6D27B+ngaAhHlpLQq45XQoFNUGUp5Emib2DINEhQpDydtntKxPJJS2PttePFPSHzkd7YS/mZmypVgA0LHUNADywo7sFGjdUlqm7rnvHCv7dh+EtOSuNHKwDqNcuQkmLf5WnxIOPSTWcI/RQKuNB22yo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639caa44-8f62-4630-5c8f-08d7e9cf96f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 10:50:09.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjsKIGW0kIxvL+vWM6ySXls1TKRvghNCRhIegdMII5PjTaMua0dJln8tKf5k/W20LYcGP0jQTet0m9fdT+Kh5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4244
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/24/2020 10:14 AM, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 03:39:38PM +0300, Max Gurtovoy wrote:
>>>> +	if (ctrl->subsys->pi_support && ctrl->port->pi_enable) {
>>>> +		if (ctrl->port->pi_capable) {
>>>> +			ctrl->pi_support = true;
>>>> +			pr_info("controller %d T10-PI enabled\n", ctrl->cntlid);
>>>> +		} else {
>>>> +			ctrl->pi_support = false;
>>>> +			pr_warn("T10-PI is not supported on controller %d\n",
>>>> +				ctrl->cntlid);
>>>> +		}
>>> I think the printks are a little verbose.  Also why can we set
>>> ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
>>> we reject that earlier?  In that case this could simply become:
>>>
>>> 	ctrl->pi_support = ctrl->subsys->pi_support && ctrl->port->pi_enable;
>> for that we'll need to check pi_capable during add_port process and disable
>> pi_enable bit if user set it.
> Which seems pretty sensible.  In fact I think the configfs write for
> pi enable should fail if we don't have the capability.

The port is not enabled so it's not possible currently.

But we can disable it afterwards (in nvmet_enable_port) :

+       /* If the transport didn't set pi_capable, then disable it. */
+       if (!port->pi_capable)
+               port->pi_enable = false;


>
>> User should set it before enable the port (this will always succeed).
>>
>> I'll make this change as well.
>>
>> re the verbosity, sometimes I get many requests from users to get
>> indication for some features.
>>
>> We can remove this as well if needed.
> I'd rather keep debug prints silent.  You could add a verbose mode
> in nvmetcli that prints all the settings applied if that helps these
> users.

how about:

-       pr_info("creating controller %d for subsystem %s for NQN %s.\n",
-               ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);
+       pr_info("creating controller %d for subsystem %s for NQN %s%s.\n",
+               ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
+               ctrl->pi_support ? " T10-PI is enabled" : "");



