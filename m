Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7AC2B8BF2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgKSHES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 02:04:18 -0500
Received: from de-smtp-delivery-52.mimecast.com ([62.140.7.52]:56906 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgKSHES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Nov 2020 02:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605769454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b6YNcNLewJnkjeAa8IX2I+fdMNnkiFarcx5T287JJcI=;
        b=ej/Cu8yCpMx/uGZqRUVl7f15WjwaHawsV+J4KF+lLjS7Lsi437ht4p5c/ya/lCHIxbysca
        L4Glw1YmYFleDrFVaoUZaxmTxxNypR8WxVKi0Kzgkc6d2DGvNqULP1NC3WtfUSKmJQjxg+
        pSaCmBspiyvrM3GFkVrRsRJ5Cz3ndzY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-2vAfkGckNLCVOBPO4qxWRQ-1; Thu, 19 Nov 2020 08:04:12 +0100
X-MC-Unique: 2vAfkGckNLCVOBPO4qxWRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzt56oTsOlT61fb/pI/8DRhQnXJaFwDOXSFXIbjwSmwhJtbO4jxQfzdjaCPOkW1zqiuJhBVtdf92T8yrYoWDWWjd2BxZWcIm/aacKSWEL1b4ucPtRndZ5UGC+XbxcikwfhmH+F89MpJfjRX7Cyot71txec/R2C2/uBjmKe0lo4qmGyd7T3lE+tJra3+N/OOaypoSaXDNdjMnDbS3Uj60oeLfmRPjweKJfsdTwjyip63ZBV3o4AT6FRhWT+zsESHeh2XZ5Mn8Er1QfI1HA9gLXK6vcZArmhS7LiJuksyeySi6pjn7pOi/kaNM75Q60AF3Ji6yHgbl2FNIDzZvGGylDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6YNcNLewJnkjeAa8IX2I+fdMNnkiFarcx5T287JJcI=;
 b=S0xAljhiuMfX1ticVq53xYv7a0G2ZfOvG6K3OBsJmiVKaFv05ZFkWFGyMz8u2m1IUrxXL0s8g0wIK28ETZ1vQm6VJlxikeaRO+QoLQVIADMfvut+InCizI29D8dy7H+WNAcp6teN8jsqaNxfefNS+TUwVLgK7W2UKZmC9VSzPReYdbw6KADrMdcLJUVLNYVD0/dFztoAc/VcO4ez+LYLFh2oScMnx/p7Uzwxk74mHZY4D1xpINS+Mq2TF48yhPhwrLgF5DD6WX+yeI79Doml7rnNvhV+J1eSJ+63NXWx79qfWseNQh/rao0/257/22dgddWM+Duz/p2y9Y/PrzJI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DBBPR04MB7868.eurprd04.prod.outlook.com (2603:10a6:10:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 07:04:11 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%6]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 07:04:11 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core v31.2 has been tagged/released
To:     linux-rdma@vger.kernel.org, Gal Pressman <pressmangal@gmail.com>
Message-ID: <420343ed-1aa6-3db7-da8d-4bbe0b52b7c4@suse.com>
Date:   Thu, 19 Nov 2020 08:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.157.137]
X-ClientProxiedBy: PR3PR09CA0004.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::9) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.157.137) by PR3PR09CA0004.eurprd09.prod.outlook.com (2603:10a6:102:b7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 07:04:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f8102c4-c00d-4d9e-663e-08d88c5950e0
X-MS-TrafficTypeDiagnostic: DBBPR04MB7868:
X-Microsoft-Antispam-PRVS: <DBBPR04MB78689F2A82621AA68330728CBFE00@DBBPR04MB7868.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoTaXySmkTfnjGXM17/6Q/U9PmC8tjwG0FdyqXQrtoSGaOwiTn5a+OXo3NoqoYxXjZRsT1esTlJgcUauLlpsYsaPNhPAgRjhw8WlW3x8V1aNg/qwO52t9SBOlZ4FAeSCFJqhpKcKGMppzSulI/pqJmRekwU2f22j/mnzU59TupWdCKkEnzZhOD27or2AUsdbDxf9vA8ee6p0endZNc5g8SxN/sTQ0vXFHZPmYWPdrrM4sLcR6XWWJO/KescNnU40fhaQbek0XhlPb9he8wcWYTZEcW2fKH2dEME5IV7b0cx0r/93L2KvDs6Fq+3+iM10eP/zGlnKWr3/F1TUhk8aUZJJURmWHssiAVkKJ6eD6LW9MOyEzNQDsBfb9DtzTI1wY+5ukR2oWwzlbkMP2oAnJJFjA3/6c2P+yh8kTREv48+wZtv/Wv1jgmZ2Wx0aMJgwrmpMN7S5gbne2yko6iDVxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(136003)(366004)(376002)(346002)(26005)(186003)(83380400001)(16526019)(16576012)(316002)(956004)(52116002)(31696002)(66476007)(36756003)(66556008)(86362001)(2616005)(66946007)(31686004)(966005)(478600001)(6916009)(6486002)(8676002)(5660300002)(8936002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Aj9SmdtYwiFF6ZYTj3LbJPmgD0tvHSfcnITnqlEJ5wsQwCXE+7zaN3bYk/eR0Rj1bjwBbLDZzOQNa5x5qijvJbd8oVtWAN2iAYU2iRwwEv99f67lhyYOGJoDvAMksc/QchyaCFcsXuxYjvtuT9TxX96kF/J1uZwK3iQFjDy8FVrNoHzYizcF4CEtqmw45WZVhiSjSRtfencRWVsNesqBe09Egdwaq4I0zqMLTOQUIAe2yd0qfHgu1mlimZAuuj7QNnxRmx0W8j1OqoGfdZJLnwBaX4tArW1H0MJcpIJ04BxFjtb6QGldfhUvP1iRUGZo1ETAe42W4HbihQUvnKhTEN/EEpp+6+waXXtaR1xjSZEyncQUUuqpgQOOUWkr68FUuTyGnvNdoLW3Z7p428TY1unQlhbI1HLnMt28D+Gg6n0ctR4tAtWLCfQps+VPMJu+s59M8oGT2TNh3uqJeB+LQLq/kgjDIhekZaWdUFnulC247BsSiQzd1iRju2IjCKyGck7U4vfFgnEz8fArOdeBSsuEPkbPSHtzcgjuGBwFfP+H4GdsHDo8NM7Bu10PC0ZZjb1NTdtW1XRfB+FDaNI7ApTR7owMitMdknzYwd+YOPeyelV23rV6oU4N96F3lbyUUV4eyvuQGAQdOlXL+k3gT4Sgkq8wBvlbpCovjfInqXtqNRU3kI6pGoI7eAcOk9BPP8i5yT3xJ28WU5PaAZxbkzjoRcjVQ5Ds54fAsr4QKPlTCU7yvFZe5J8l2b6e4srg31shYiHXLS71APU8fIzcAalMpEp1ROvfPSyq7dWuGjt4D0kI/jPx3Is7xL2vTvmKsNDFH5RcWew2fBVZ0SYAKHQ9+0yIeTfTCjFVjEdX4JkgOdgKMIeZ5htB7j5wcAlOIirCO4vCcunRSqnd+wwwig==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8102c4-c00d-4d9e-663e-08d88c5950e0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 07:04:11.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxyW2bqtVDzd0mHNAPeAyIhg6/G+fNyQ1n98Qpx0qWSr1Gpg7eVg81LWI4rn8uHoDqTgaCAR/Wx96g6dU6vkreKD1QsToYHhrZwyuANV46g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7868
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v31.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Wed Nov 18 20:41:35 2020 +0100

rdma-core-31.2:

Updates from version 31.1
  * Backport fixes:
    * udaddy: Fix create_reply_ah error flow
    * efa: Flush write combining writes before writing to the LLQ
    * redhat: no need to recursively remove srp_daemon.sh
    * mlx5: DR, Create NC UAR as default but fall-back to WC if failed
    * mlx5: DR, Fix incorrect use of fl_roce_enabled capability
    * mlx5: Fix wqe size parameter in wqe signature calculation
    * Fix cmd_fd leak in mlx5_alloc_context
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+1ePIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGd8B/4oFQXbQiqPMYmlwM2w
gzj+gYOmuPmKNwGWey9Wn8FDk7HZYWzSK02AM2UyBxwQtYTkJM2EyfpbJoRG1I29
iO9jFh2IGi2yzL8GvE8A9B9VbR1iprXptExIkv7Y27jPqVEiQGHHlwatFHBfn6m2
0/ebKH3sqZ0/v2r1aAC78c1wWZoYQNf5MVcUb/EJhlLTfS8Mnvf2kF3dtFj13lYm
YZz1k88PBnsIhBI2AIBX0CTmSXXIjiWxn23Icq55UBDZFn/ycFFycy3fklnSZTwr
5gj/iNhJSta5LK/IK2a/OxxD+GyvsU9FOjviP8YxFgvGcvcy5eiT7sxIn8P/CUUW
79Vq
=luUB
-----END PGP SIGNATURE-----

