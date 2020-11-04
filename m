Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE22A6161
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKDKRZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 05:17:25 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:31591 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgKDKRY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 05:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604485037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8H3QYrjnsyHywwLbZtkG+aOSO2tEEhm91p+U7pYKIiI=;
        b=YGewEJ/9R6du6Qg6sxZfyQkWa/LFHwiVmh/js8XiMjayRYMD/O9Vpij9iPcixCwsmqfF4c
        5BLZm5vHWmOCRED5gCgnmD/tiLuakQNGHzsrNrwSPocGwKdROcGAUyKFKGv/fkukstnZZX
        whhdsfVeeSGieeVLSOHVRmi2/qA2Vms=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-uS-taTANPn-kFuYT9UgnTQ-1; Wed, 04 Nov 2020 11:17:15 +0100
X-MC-Unique: uS-taTANPn-kFuYT9UgnTQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feivztDdw7+fjOAazTXNDxxtW/g4hdWThKoskX94FnAVFIn5bfLMX1fcpEr7qRWilomUzb1bCSpqMXh654NfyOvJ5t2eSU0MdDs8qon67RALXvoL4lYaO960qHOzMqjXvUTqLrkuYPYTCLPNpAIgE8pd2sj12nX2BF7DwHCf1yevwvMfasajKrWurGk6xUcfHfbrcMRFVx10wQBtsetfauhzKJ6AgknDejVx8ypknmLjP2blLs1z8t01Zyvyb/QtKqkuzVFf80sq2VQCQJXzr9ca8+Eg1Rf/I340YKsGaraN8VVdyCovEf3H9zb3z2VAciwI9hkpVK1PVN0ZcIj/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H3QYrjnsyHywwLbZtkG+aOSO2tEEhm91p+U7pYKIiI=;
 b=P6lLmUOTIEiSNU81QIh/H9AJPFagJ3OFcTp2wMjy8qi6W1HQmzjF3klr1eoglb6xIKZm8UNc9zJn6GSOPGMMZOcK2yhxa5oVvuxoeGG6jCYyTxu/SSuO6IoQvaMTC6X2TKbq6w+dqHf94UOUTcV2Z1RO8PjuswMpx+3aiQ6cBa30X/RheL6y39pTr2MeETCURxr3bCr+nYQjMVWhvLo4UN9T2POWqW+FFEk89i1OXP54x2/rKhS544J+jdilSkLBzwXxD3hDDM3/9eWBxDPQhX/kGz33jar5iry+efvw6AObWoAcvx2eepBbt/FtLgMBk3bwM/m0VXmPdQf/FLYVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DBBPR04MB6300.eurprd04.prod.outlook.com (2603:10a6:10:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32; Wed, 4 Nov
 2020 10:17:12 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 10:17:11 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Message-ID: <6c16ba4a-eb59-7a6e-36a7-c81479490ba5@suse.com>
Date:   Wed, 4 Nov 2020 11:17:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.157.137]
X-ClientProxiedBy: PR3P191CA0051.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::26) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.157.137) by PR3P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 10:17:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad77dc07-066b-408a-a13b-08d880aacb57
X-MS-TrafficTypeDiagnostic: DBBPR04MB6300:
X-Microsoft-Antispam-PRVS: <DBBPR04MB630021C96151D1461382B0FEBFEF0@DBBPR04MB6300.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXHHhKt3x6X9qYMbLZJq61zjvDPMZvvYT6yB12ijFvyDGQDN59bTiPXRRcSi3khRalCfWZKYF7Kf28IQWmRM2sCbzWU6afAdsVFTdENJdYrwkLMHgIfFEfRl+ZNS++ieR/gJfxBBw4Q0prRDZhjHaN/WyTnNSJE6zi+Q2NcojfDMOUaQL168PSoqmDu5MZocl/H0idQZcs4okQh41iTGjskBBCoXNXITOcVpmJV3ExThSb2NqvfFTU4IVLUGkZMM34qz8L4JGKaZjD6QpWE2+j2+BADadinYBySwg4FG+iNIw0+7mrzbwIufgXneceESHn8vIIn6ULkqPv0Wa4g95BCBXOWrEKDspjpujx7OhYDaXazqpYkuLZywzfKE+O+Kx8MaF9TUJa4xJHV3jCv0DjDvtJQeFZq3Z/MFx8aXLDtqqTYvBsP4kRbn0kL+L78x8ttRKCu6oOtpGs17AtZIgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(478600001)(52116002)(31696002)(16526019)(966005)(956004)(2616005)(8676002)(31686004)(86362001)(8936002)(186003)(26005)(6486002)(83380400001)(30864003)(2906002)(66556008)(316002)(16576012)(66476007)(66946007)(6916009)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wZFcZsm8TbNfzfdxR90gab6WhTPVvLaLLLUxjaRBGLgkcEAmBFVWyr7s345NG3n0h2fhrIx/bSFHyWEoQvVdusAKL5J+WD1IFt3iF7ft8YnAKGpW4UIhO1sbQhuo0AY6N17pWq2nGmlFaAKIRVeM/OZHMhBZ01cZ63NhOCJkBKJ8bXNrlMNaBF2CCV1lC/ffcB94IAQM/smYaX3gwMHXlfu4BN5eaOdN/m1yxR7Lc+rD0q72ak4BYpAHNIxGOS7MrNER/CSADfx8Mahq2C0V1L+uCcxMW8t8FA3Jc4bNgHD1/tP4NZh/L7GMKJ6uWEGRylG9onGDySGICoBy260In01lK4hiabcoT1ncFjlX3uS5DYRIq1xUmK+jIEc4adctGlBniJfzbxW7XdCW1YaO8h6+IdXjjnzG5q63ii9jkO4fv1+5mtrHY06zQINBCuF6gUYwm8VzuM7qrbURV8dn/oLLrCEj4IOfcEzqmQnrtarqCU0i/0tfJJQ1ZVNuefb1IAZADeqCWs04bmuRdlF9mIY/ecz10T53uVs9u0bCXdrYTOvER7rKwWhpAZHTBtkRGTfe8ogRqIG6Ln4kMm4zLogGA2wAx2TvMabaZvXs5BYq/G2KjmA3SGZX89lZ9F7ALMybQMQYOgxqPuBbmv+B6Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad77dc07-066b-408a-a13b-08d880aacb57
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 10:17:11.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpyekMNLM3y0yr++xt4RvaduGcqhlvPqSYKgz4kkc+ll/rvV11HeBvFeV2kpD7Ji7JAnq+oVqU9b0WNF4vDgJZA1eIVHscWxyoUYiomqERM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6300
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
  * v15.12
  * v16.13
  * v17.9
  * v18.8
  * v19.7
  * v20.7
  * v21.6
  * v22.7
  * v23.5
  * v24.4
  * v25.5
  * v26.3
  * v27.2
  * v28.2
  * v29.1
  * v30.1
  * v31.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.12
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:00 2020 +0100

rdma-core-15.12:

Updates from version 15.11
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Fix ibv_create_wq() to set wq_context
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1e8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDZ+B/oDYt8aVh2yAla3mD6A
1feWWD4l1sxJEAooyEXJfCw67fQA7JDbAupn0PKh++1+DPKnbBAQDc6XBANKChV+
+GoBPUtKbsIKt0IGKAkG1PZZybUcrpNhSqoapWZiIEI/cM3HzNqjCOuKzqHajGUu
2tnfpNbev5/+z5prWs+6DQFetiScbZvM/HKLAWIFxNo4J8pp956VCweo8+sTaaTU
wI++fTmP+0CmteK45SIccpe/OEZyp2HmHqPu6pYlEQ53kHaIqjdWsLFTNdYdRyx5
9uwpp6tNu9qZLw5nkIzS1hJ/L3UtkrFzziY2O67dZz1aNxK8yH0llGdtSNcjbGAR
uwip
=CWaS
-----END PGP SIGNATURE-----

tag v16.13
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:09 2020 +0100

rdma-core-16.13:

Updates from version 16.12
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Fix ibv_create_wq() to set wq_context
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1focHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIAGB/90+7Nu0B0b73UiABOH
eXuYmk9rvy4SRwQf3JVS6oEswSuidsR5NC6aS+qn8YXWf5WYNKVqmFnypjPk5UwD
Ulytlev2iwdvVWu8YZFlulsb+TBNHHH4MAwH+ldSOAuaGSfJyerGM626h0iXUE6k
JOeF+LT/otyQfNKyCoQD609EeXldqOP3wJi87uXVniSvEJIXgaMtL5MqarXJT/7l
vt5bJ19GYXvOiBplImPnOa9zlUsdwT7fUwC5oxzHk1gLUyilQrgJiUb4yVzGSaAQ
y9ljOuNxYJLM+S8X8qcwK76+ofHtFQEbnkMEXXQD2xchDsG4ZQ6xZr7mxbLhapzp
t0Xk
=yO5k
-----END PGP SIGNATURE-----

tag v17.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:17 2020 +0100

rdma-core-17.9:

Updates from version 17.8
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1gAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEl6B/wLvnx4KUWva6xXp5jA
x0/zkwAFYGUr7vjUQET/5QQALZIVdrKmBIgC55VZskRK7mg+02jrwNQtjU9U2dwT
Gt311t2c0RTlFdH4eRgOSRT1MaWpmcEztzYg4y7xRyZVV+ZdC6ZD5HjOAC3VdsNn
afi3vVtVQhWx/pozJPTNWzXbpXhNGTkeT1+oKzGQHie/d7gWGHo+aVs3/26lw1b/
RcjUzc2mrqRwKG9IWKdVKXYQWhC1QdJy/RleR24NiSO1VlXlHiNRNmWGbqQl/Dyj
IVYOyG8cx83Iybzyvls++EnvE2Ww8TuES7H+PihoDpHO7Rv6EVE+Ovv5Qex7bueD
CEtE
=WJAi
-----END PGP SIGNATURE-----

tag v18.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:24 2020 +0100

rdma-core-18.8:

Updates from version 18.7
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1gYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMgqCAC9vsd2ba3FexGzy/MF
zeFr3H/SKTDBIvXQXsf5rxfQTac6scM7qgcLdBjuxoKGlVl36fA0avNb7l+PyAot
EwEC5/JJMF8cWBJIo42xuGlLKF8nnM3Z+7FxdYjCIC3xUBGoyoGFHMw6UUYaUrhT
g7UPNxeFMJJtxGIaJ+ez6HNvpj7HJvHJAPZPySjT+E/muH+XfpJSXhLahf6jygy/
/MfOoB+t58nt9tG45S5Aa5deRTYt3oHwBrUJ7iUc9v2p0smOgTo+8Y1ky95JZlNK
6L8oy2Zv0GagpF1hm4cTR5Zsosjqyw8/uvEgdPA7qmJC5AqD0Y8Xmi4mNgDbcSdy
dDsd
=+u8U
-----END PGP SIGNATURE-----

tag v19.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:33 2020 +0100

rdma-core-19.7:

Updates from version 19.6
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1hAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBSwCACCcciTD2RG4qWHVQPT
zYREM1FicTAL4uWqLD2ZkwQXma+fQ8F4ZzO9NrOfREg3w5U29gvrUBFWFgj5bIFG
Bt5eeJV3WUsnKMUbTljysMXJwSt6qNsGj8PcwDmLsLxdxoEzWOBj7BOrZWN83C2R
UOjZorJhDViFHU4X8IsAO4/megYcUlLPTu5eEQDLmabpr2uPliCF7d68FJfDkbrz
Uyq5TiAVtsIe5IqcIO/QQEJAC5udY5lJfyvQ9yFjtxDmxsyM+ewLtJLLxvyVRLhe
snVBaH23aV4hu3mr4CSvjt5hV8+3EiXvnOwviD37yUEOtn8bwhurobdKVNSZ4oNU
9o3a
=fms8
-----END PGP SIGNATURE-----

tag v20.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:13:58 2020 +0100

rdma-core-20.7:

Updates from version 20.6
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1ikcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZH8cB/4nQ+oPnMgWtbfQ5e9a
lbiGIEWD81rrs4TJDjlQWjcLhLBygVTDQsDmVvotcwbeQXGM2GjFs0S2MDwxDWZV
cusDPDWmyNncPiV4NTDIgz4CpSbUhY+JHw4Fb32aNnuAFgfuoY9BC6PDweWfDmOk
QXTKB4Ov8t+OMyDuobkRsmaVDFP3zNcz4hTACdLnnnfFnyz8Cd+FsCH5ZKkh6SUl
Iu2B5fmMgr++xXsslBot63huA/iJDvHPHULDz9Wx6eS2wU0SYOnpOQ/VPXsNnG8z
/FgqS7ltTpplOZsJqspaIH+7F1zadMv/1HYGtC04KnEyII3ODa2oE2wzvfFnxGv3
dYxp
=5DFD
-----END PGP SIGNATURE-----

tag v21.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:04 2020 +0100

rdma-core-21.6:

Updates from version 21.5
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1i8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFhtB/45WNtUsgvPDjvqZ9o5
/xWYHfiVrUnwcVtJyujZVn48XTJFSS+Mpr4xc/Z+00pMM5UksWY9YWZCShwr5Rj8
qcodhALpDRgkuvr8cDvWd1WkAAj48iN9tE0u/r64vnkNVxK2M24kBJJnalSHz+JD
N3MP7PGcn+jdh8CBIs3/pRRJKob55B/lMXqzskyL5CDbI4bL0fVNpFFuR/QMWIth
bGNmgXW1Q7POWpzC5tyhO708eAceQUAsFsObaF6wJ0YU/+9KcAnDz/OJF+oTQN8L
CPT3JPDtRj0GjSGvNH3kEx1CQCHNmQUSXdqFOpOYbDm1tfXOyK8j0sYcSQTHJclD
XkIL
=ZusC
-----END PGP SIGNATURE-----

tag v22.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:11 2020 +0100

rdma-core-22.7:

Updates from version 22.6
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1jUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJHXCACJn3GEupascrpkNpL3
dX59/I7Ev5yD3VRWM7gGduhgaavAhZblhARm/HP3pmu5EIqn9O+9Og3dqXhbENpf
xHDMMyBT5peR+MEf3pYrt23aEPjv4lPvE+QV1jX6Dk1g0y/rHySZQvULHHLfTPtm
PXqGPd2kuCFEIFPSi6Vex7vFmXG0bVej2zxWYYk0rOaAE2mt/lJwOdibzzErMebx
Kgk7dVJ4ZObTDGgZUSoOdrPplTQgAjd7lWuG9vbUt5Psj980JQgY8YDo5RL55InT
dszDZERwYJbhO09UDEKwBrBqaeR70S+byBikCimeXiTd2UnVtHi3sU2CQ9BkgcZM
Jl5X
=hQcQ
-----END PGP SIGNATURE-----

tag v23.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:16 2020 +0100

rdma-core-23.5:

Updates from version 23.4
  * Backport fixes:
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1jkcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCsuB/9jZWjJVJZuGxPlus8i
x6lOXnqG+4Jhp8Mhs3+EAHRIkNR5W2JBGdzwPMUgfdfP6eimi6VmwIl5+DcU5tZ4
CX1GhTjzZCWe7rDCvcsdwq/vmqq7oZDjJRnbKaUQSDqZxEiExCOF2TckS6iorH7/
OZmc6krslk+NsedP0Iv3HX6pwwWqNN2w2GdaBuhOUlOkjjukN1x4zzMJqmDyG4Zr
MCovW+XkqFXHM3AZjE3+ZA/DoUHULdUOu7MEHPRe3H1NylpMaLstAyxXu0h/gW+F
SQkgZ8AFyxVFv1dmzGIzFq39bTNzfE6di6a6C9BT1ruKPUeUQDaWR+66iZ7JmObu
Mg0g
=z3fx
-----END PGP SIGNATURE-----

tag v24.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:20 2020 +0100

rdma-core-24.4:

Updates from version 24.3
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Close async_fd only when it was previously created
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * mlx5: Allocate accurate aligned DM memory size
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1j4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGNtCACF8iQbKGWyC9wv9fkf
UDzRWcDMREZrGSVfQ9+1+UVWrdReKJ9XWvsvGncduIR1BTTkomzxr0TVXlx09zxe
bwySNTcCiVJFlZkpMdS0kh21sQSnlDdMMweRo72ajA/Sb+wIiRZG5Oscvnar6LNh
kIsTEslQVlRXdy42Uw2QmHzHDFkX061MjWktHvH/Z3acIfcLDud4sIDYi7+JVdmN
YIMBXC2u4d2I6vwq8g0418k9lAHzpzfhbHSr6/iRzrTknwxdVYfAYNswKtiVWWkz
InD7nbCBPgfyBCUIAtE7aeoymvHH8dGqQDVJx4nZvwpLIDNdXHuP24ycjukYKYP2
VOfL
=eBdV
-----END PGP SIGNATURE-----

tag v25.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:25 2020 +0100

rdma-core-25.5:

Updates from version 25.4
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * verbs: Close async_fd only when it was previously created
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * mlx5: Allocate accurate aligned DM memory size
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1kMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMggCAC4Ihn1lRy6zcuYfIOi
Ho8mT7XewrfR7upjsPup6mSKPjHc4xvTD/KaiFwPO5Q+bEbiYLTnlFfmPZg4HMbL
2fl/BKu+z01UaaCCIUnFKdXJiAM/B/ovq7HXmHx/WDrzvV+5r/eATgG/8LDAsSUQ
ycUtyYOmY1LeYd5rZqmk7RK1PmbAo4BeUbjQFRtOElfOOf07DiVoJcGjboY4+KTw
eylMRHWf0D72BCJlw99wAwaXB/G6E9IB73LmVdYBRDcCGZHf+cWpZ/gu0Oz7Gqjn
SjKSYQ2jcYTD3mR9p5WTdDI9MFnFG4IQUcBRoonZkPUEna5P7vxECHiUC7jPOwHi
5J91
=SJfr
-----END PGP SIGNATURE-----

tag v26.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:31 2020 +0100

rdma-core-26.3:

Updates from version 26.2
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * verbs: Close async_fd only when it was previously created
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * mlx5: Allocate accurate aligned DM memory size
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1kgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJAaB/9qV9h+W0HqXwr87E5i
rr0lqAAk127ds7nw4pnFPL7RBEqrMA8jJICdC5f63IjcDCbf9ROrKQabqkvsyDUQ
4P86ha74pff/vIf/wSOh38l0rJ80IxRZUC62tlLKAZJP8uhF0OQTX9JT8Y+UBCxU
N3KpfcXuek9kiWNHk2gzDGfiR5hyDlMszfGs/izW0ysbGMLiDYP43R08HlTMm+Ap
KVuHhtLHzLQ/+xb48cKXELPb6GOi/VleazmULPN/FuyFc/7fCYxuJN8q3sN/hXMp
MO/JkCpFFmm0A7i5l+kMLZ2l7MmT3ZwvjkwxvEoDA92ojgVEUeBNxgo5Xyz1ZPrk
h/0/
=zabq
-----END PGP SIGNATURE-----

tag v27.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:35 2020 +0100

rdma-core-27.2:

Updates from version 27.1
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * tests: Allow zero vendor_part_id
    * pyverbs: Memset the memory after posix_memalign
    * verbs: Close async_fd only when it was previously created
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * mlx5: Allocate accurate aligned DM memory size
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1k0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHt5B/9XF1H5J0ZrlWBpAPsD
pXkYsNplxl7C8Uk88aoTSrO1CG8GRklZeO83eqzth+wv51WW60I+TJyaH0ioDS78
oZMMDCKEtir0rSSi8OPoM3n3hUOGSNV9fVld5tuDqdXhfINhWGqM8Tn6y92r71d3
vbFgcOdPT44/w5ersZgud5UwvIhLSX7qrjQtze7G4rCMHNpFY/mS4cRahXRNjJPV
yJ3xGgxbv63IcdKSqRNnq4rj6QpaVRNeey9WylhdxGiSH/v1XWuQQII2sI9V8w4P
Pi/B+rtk92VEGg900jbiYCD+mr1DDZpxclhovd/cLHZhRbVgUyMyuXX2ezg9EjpG
q4Bh
=gZkJ
-----END PGP SIGNATURE-----

tag v28.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:40 2020 +0100

rdma-core-28.2:

Updates from version 28.1
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * mlx5: DR, Support match value of size zero
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Set attributes to zero if query_device_ex() is not supported
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * tests: Allow zero vendor_part_id
    * pyverbs: Memset the memory after posix_memalign
    * verbs: Close async_fd only when it was previously created
    * redhat: Fix the condition for pyverbs enablement on Fedora 32 and up
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * mlx5: Allocate accurate aligned DM memory size
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1lIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJBNCACJWFT7DxT0ZzgFLHr+
cC7gEGhTFURwN9FM5AmBZUWehAcZYQWpYnC0zkIU3EL/0YP+CwOWYtsJzEXB0sYs
/rlnB5Xw9P0h3AY2yaAc0kMH5DtSth4pQEL7NCX4a+GvRuZHRdb0tsOHMBLlYHSD
9FfuxfGbkwr4blTWN0EXa7Rnsvaxodk8dcR4VNPvqeBMsA8RMaR196ty1x8ZN1tc
OwhYnIB7fBROrRaNThMrUG/Iikldz2I2+Znla3oGW7spsIRzSA2luX2Au4eJ8C6c
dm5FN3or21XyubepGlo9z2SaKKQzjyXyzksmRcrlFMtTDDAs1f9c4C5Lazjf8+3y
H8qH
=Fi3O
-----END PGP SIGNATURE-----

tag v29.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:45 2020 +0100

rdma-core-29.1:

Updates from version 29.0
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * mlx5: DR, Support match value of size zero
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Set attributes to zero if query_device_ex() is not supported
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * tests: Allow zero vendor_part_id
    * mlx5: Fix an issue on P9 with legacy UAR
    * pyverbs: Memset the memory after posix_memalign
    * verbs: Close async_fd only when it was previously created
    * redhat: Fix the condition for pyverbs enablement on Fedora 32 and up
    * mlx5: Fix potential arithmetic overflow
    * libibverbs: Fix ABI_placeholder1 and ABI_placeholder2 assignment
    * mlx5: Fix matching on vport gvmi
    * efa: Fix create QP command over ioctl interface
    * verbs: Fix ibv_create_wq() to set wq_context
    * libibverbs: Fix description of ibv_get_device_guid man page
    * buildlib: Fix a warning from newer pythons
    * cbuild: Fix build breakage from APT
    * mlx5: Allocate accurate aligned DM memory size
    * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1lYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBgiB/9zFasBQY5YFewbH5Ay
MFTQrmm8pTG6EG+5F3j5abBnkmR8p29/dooTFdjAYmyLijzgA1PD5IWgRv0k9G2x
UjyQhaVZMpjpmxd1XjTvxJVM4HS0Tbd6X2EOiYbMPnN1hHE3/ucGribRx/lEBXMF
OJTUmhHGlMdYAGYv7ZnazVp8FMrVhYoPwtM3nMK6RtLsSik3Q+RNYygIYobYbZTA
GOc6yIJxEfYzvLaZXMSkd/4vBC3rocjVx3y79jhuveoMGXG5jGLS56eJ8qls6sHc
pA1vRCAJDCrTZBJCntF40jQrYW5j9N5N/p5FyU3t1Jxpx/NWKigfDtEt6JhezP0q
YxIS
=mOHR
-----END PGP SIGNATURE-----

tag v30.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:49 2020 +0100

rdma-core-30.1:

Updates from version 30.0
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * mlx5: DR, Support match value of size zero
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Set attributes to zero if query_device_ex() is not supported
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * tests: Allow zero vendor_part_id
    * verbs: Use WQ creation flags properly
    * mlx5: Fix an issue on P9 with legacy UAR
    * pyverbs: Memset the memory after posix_memalign
    * verbs: Close async_fd only when it was previously created
    * buildlib: Use the right container for azure pipelines release mode
    * redhat: Fix the condition for pyverbs enablement on Fedora 32 and up
    * mlx5: Fix potential arithmetic overflow
    * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1lscHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCNJB/sF690AlBeImvFAhDc1
+NEo14FNP6FrAW758mAShMnq9GUBSa89gnxjG7cxqR+pvFHsmR2whFdw7IEllNgo
K3IjutdviU4AJF9zZHWdAWnU4ZIM/7YeuTG8IP91P0nNohpqAAlGxEmVU+5K0zPh
awBmIfh1VIR1Dm2LnPbPAPTcpkKswiToFWlaRCpINnSST9v0Azxpc69MjzxGBAEF
bbrSuGSi34AwCqPBh+UbkuzJMbm12mHbTwkaK9hXkmB8DkX/fsAKkMFda5zsIbgE
zLiM5GuMT98ICjWg2YApPGWcOouy6X/OQZGQU7QEYEvQCtrUheJUUPEiYNAvtCrV
2zhW
=7yRj
-----END PGP SIGNATURE-----

tag v31.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Nov 3 23:14:55 2020 +0100

rdma-core-31.1:

Updates from version 31.0
  * Backport fixes:
    * mlx5: DR, Fix error flows while adding new STE
    * mlx5: DR, Support match value of size zero
    * srp_daemon: Avoid extra permissions for the lock file
    * mlx5: Add fork support for DEVX umem
    * verbs: Prevent dontfork on ODP MR
    * srp_daemon: Fix the spelling of the name of two symbolic constants
    * verbs: Set attributes to zero if query_device_ex() is not supported
    * mlx5: DR, Check for minimum ICM memory capabilities requirements
    * verbs: Make sure VM_DONTCOPY removed
    * verbs: Try access device before adding it to device list
    * tests: Allow zero vendor_part_id
    * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl+h1mEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOhtB/0dLybw93ISA2Yv3l3Y
x9YWc0MvPmh2trFgVNW0GxXzsS1qtkVp8z22R6f2R4vTm94wzi0jzmZLT+SHoAhV
G7fQtCfgJ6BGlupG5BJbbymnygY5LTPbqroK3JZr9E+6K+UEinIKMz0gj77ljN5s
/+MOtgg3YDsJen7vmVQWa2YV754w8WuN2XTbl25Ou/hgqfvsf3CHqhpE+i8twWos
PfTDiY+atcFPpk+KZtRY8/T5k9w7l7vq5CEPMZHbh+OfE5pzIgK28p+GoTNxZMYS
h1S0zg+MGitrkBZIB+zzL93Iva0+4vP+eHvzutdB/IE0o6GI5u85eWtZf3nzU1Gq
KLlC
=zN6D
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

