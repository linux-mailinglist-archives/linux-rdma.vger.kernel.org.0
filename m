Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C621E3061F7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 18:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbhA0R1o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 12:27:44 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:20438 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235585AbhA0R05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Jan 2021 12:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611768347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jcEXcFYk7m153Cci4AcWc+7VzoUbpfHO6qG1EoCFYmg=;
        b=hddlLpUrZI1O7ieHTa61Ri6m8eRY9ckcr0els3DSjXzLMMRJIsWOBTwa0J3aCcw1jIRinB
        fw3PUsY78UMxDm0PYGO+XEQkBS4KuRseI1Y7SP9Ulvw/6rZ75VU2fvxPKqtIMeAp8ZFfKB
        ODrYUQzHMMxhGu7Esgnft5Ikzjfnd08=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-bPZaKTISO5WXvzURZLML0g-1; Wed, 27 Jan 2021 18:25:45 +0100
X-MC-Unique: bPZaKTISO5WXvzURZLML0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJm8YM2F7Z/VJzKwZRypq08PFKxg4lnnDKrk5WXJilQMaadczbARHsG7B40rA7/yK3Rq/2YyEJ4+2SQcHL0DuZJPrUs3uuTzwqNVLB4M19ymF7tu3YH83NaAkd6Z0nXgWD38ucSXxIwsms86C2349e4DWg0rfJaTSKKuaVdsH/82V6tCQfen1/931i33WyNXteppH7wp6UMzAifQEeXMmJ6Fvt3naG9gm53Rgrs/odT+GrIGH7fAEyPdyrDxug50Sg3VuxeW3MXb+OowXEUSP9FgE3P7vAyvgfgOjURUlf8CSLTMM7CSODo2mxgtcmlCSNEHtBM1W0SKx5FVBg0pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcEXcFYk7m153Cci4AcWc+7VzoUbpfHO6qG1EoCFYmg=;
 b=SOrOYS80im0ZxPRXbHd2Wd2KfuldRXqPLJuKIxJR+K4pqGeEa7Tz4HJKGrGDKPcXvlx4RgsJEql3bgPiHjoQL2k2svJWKNE76eH5f3lqL2KLs+6UTe0+FUOrCf1lB0KjdL4/SH9a4E+16JxygPzMqMsMV9GWtjx+niF7o5BI/mz20ibP2Rq3OXDdMf0RjFyXOuLlGF0O2bdZV2jI5+TCJ4m8TtIHbadMU4KNZSRbtTpfP1onUZG4PxjTyJb0/iQScYCtTzjXoc6xmAizD4yczzxK20dp3t5j83+IgOCFYPy6CV2VCPuG7Odk179cRaWWnfSCbjo9uQtUyvIE5ygylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB4553.eurprd04.prod.outlook.com (2603:10a6:5:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 17:25:43 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::bddb:c1fe:f800:8f1b]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::bddb:c1fe:f800:8f1b%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 17:25:43 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Message-ID: <fabb60f9-5812-688a-4b7e-a167b4de86cd@suse.com>
Date:   Wed, 27 Jan 2021 18:25:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.134.121]
X-ClientProxiedBy: PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::33) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.134.121) by PR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend Transport; Wed, 27 Jan 2021 17:25:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d20da86-a66a-40a5-2edb-08d8c2e89309
X-MS-TrafficTypeDiagnostic: DB7PR04MB4553:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4553DF961C83DD6043EBBECFBFBB0@DB7PR04MB4553.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OISiv4utL6RmdoKw2K9ucwyVbCYOHEP5c2B5yueoFuood19fxpOD6XLFcw+uBK4Gp2CYg5imqJBibVr08JOP3xCgjmJd/jD3Dxc0bbB+GXth/wTYnnIF28VSyUsDPG4qYEF7K7OsDMEwc3ON33bLaQVozfxXi1v+MpqNByVF5CLWI6COS1X1HqKKRFFxjpD7MOR8WQueVDVri+VxDAZwgxn4JCZ+a0skdhZFEYPM1VsHLqsrPGIaPjrvgZkb2DTaXTBoZmyGWqnkYJl2TokpAeuSon7tyNni1NzEpO3cebrqfyrq+6WgAsMBML1aGztuIewsmpVE0RoypoP8rQaYNfr63fPVGcR6XFNcXprKjsMhsHsBwnYG6WuSqPaamOk0h4oTZwWQ1Gip0wRDWwsKGdlP8qqnzoLlOYKdYRbCHf03QVi5AhtZR6tJ2owBNe63j0Ult4zH/HfUmUqu6qmLdVvIadrY8r/jwzP0aihD/a2lfZ4u3gTzcswx7vT3C/Lm+nG4qT5UFryn1q0gREO/muIdebfOfSl2IynEBr/JfUmvSMQrwpSzpz04HOgXwDedr2Y7qQKePYmQggjWZa/6eInCKyVBNSZNWYX7DLrqp34zyJSl4kvy+Nwxz/8daloN62Trzv1Alzbx3LuPYpDT8lQD69MrWhM4ZLuiJg//iCPSp+JNcTlyPuvbEvh3JxNICC9inbmI0Fm0UmTVhjt/LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(396003)(39850400004)(478600001)(956004)(16576012)(2906002)(6916009)(52116002)(6486002)(966005)(8676002)(8936002)(316002)(5660300002)(36756003)(86362001)(31686004)(26005)(83380400001)(186003)(16526019)(30864003)(66476007)(66946007)(66556008)(31696002)(2616005)(43740500002)(45980500001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?h6MFEvKX7yELTM+jtS/npM1fCwfyu//P1sSMwVLxeuAe3qrwOwU2PVbd?=
 =?Windows-1252?Q?CN9JHNDnuFh5stdhouEdXBnUIAPeh3HngMbXKKtdhoGM8eEwlLi0Lq2Q?=
 =?Windows-1252?Q?Xu7smIOYzr5W9h+8thitelR5jaRchYE7Qqd8KSX3trIrD99MT8C7wes6?=
 =?Windows-1252?Q?NpPtdQkywxrofH29QSLvSzkqknHi8cQAFvhDi6bBrx4Vc8A8MAIR3MBJ?=
 =?Windows-1252?Q?l4eHVDT1MkpWDPQiQ6WZJilXji+tP8RLC+jA0rt4uWH7icAcAWRS15ye?=
 =?Windows-1252?Q?PA4Z2UoGPlvaRAlzWibbXo20tkgHEvhy/OvBQtW1/DGzDoo0N8++kn2x?=
 =?Windows-1252?Q?yCz3ya57+GTTlKV7ZcjRko7f/6qUVu87p4dtyPyvn5LvKu3d5zxj6y/C?=
 =?Windows-1252?Q?6XTQM8BTFnZo6w+schYkDkYzILDmnFsD9CTtcz0KUYUJePej1M862yVE?=
 =?Windows-1252?Q?iCvW0qAz+kbFhVjJmydMqH31LppFlTrTYSZ+nDLW+IzQgS4Z4Qbhny9L?=
 =?Windows-1252?Q?cnc4Ap0V9+13VlutQ8f0FD1LPv6gyHMgImDOgirXj8mRzRizePPvhiA+?=
 =?Windows-1252?Q?JjKXcbSd9PKZ0gGIJm9S9cjjbgi143yYtBRQmn7CUDG8gKZKu0JwzGrO?=
 =?Windows-1252?Q?ir3MxEKWUEOCAt/sXl/meZTzMPXF7b/9MUx5s/brkfLDuFvHbrvXklJE?=
 =?Windows-1252?Q?a1rNcvTIAEw323pJQmQ7cZHjXThNy2zMb/9kxvvvlxbDt9p2UrqZs5Sy?=
 =?Windows-1252?Q?Lb5siOu0JRexIBAMH1qlxMzNM86006VxjeLTkiMBIb8deNo7dsWAEAZH?=
 =?Windows-1252?Q?aigX7AcqycLHDk887Kc0SU4luSwtiQ49Vr0p2PYp/irqI+ysCjWLrEsE?=
 =?Windows-1252?Q?i66rXalhs+e0vdjQO4+IFtm/dJj/BOddqNrIbS+rCvcrSjliBn/CZRzg?=
 =?Windows-1252?Q?6elYnUGxzlThGH+kgxzUDq0ofo+P8atZZOFoccsh0wNKXabPCv3avzvw?=
 =?Windows-1252?Q?RjvY28uoPKWP2CKOg4Gjh2693rk1kY5eEw6iZlGmsf1uH/myqe0LyIrw?=
 =?Windows-1252?Q?CvcCnERERQkucAKDMLuxuQaupRRQxVBBvnkaF5KYGgJLeezbq+E/9uPC?=
 =?Windows-1252?Q?hWiEQzuR8OAFVrWgdCo+byCW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d20da86-a66a-40a5-2edb-08d8c2e89309
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 17:25:43.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4BDOE5P8K56wIjF6pv/QfH6tEal/6qmThYJ/kY+QrvGp5OINBcsKOVUnrWAYHYveZPIvAMeeEkNFKJLjYDAQ08Ricd3YeINs7in4+Jiod4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4553
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v15.13
 * v16.14
 * v17.10
 * v18.9
 * v19.8
 * v20.8
 * v21.7
 * v22.8
 * v23.6
 * v24.5
 * v25.6
 * v26.4
 * v27.3
 * v28.3
 * v29.2
 * v30.2
 * v31.3
 * v32.1
 * v33.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.13
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:03:56 2021 +0100

rdma-core-15.13:

Updates from version 15.12
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzO8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHODB/4zVLFKond6siyXytkU
ChCee0iNGN7n6iLuyweR4WdyiM3EffZZGZ/3EC2W2QfrCtuq3JdSJehsHk7pYr/u
UgAUIxH5jzlia+WZYXjlb8W0qbgPCesn5CP4bmnCKQZBpDa6I7hKopMM15erlbsl
tBIH+fdg4/GTzXra2GR0lqu5i6l94TuwNNZQ22kry1PVYXu3Q0bFot9M2MP1kwnU
nJh8frSBji1y/6WNys4fJAZI+as31/JDcmYRqYYD+eCpOOF1Nke9o13Rez6GdFXW
SJODnra3ghwweJvW2+GY6yq2btETWjTnqdLs14W7CmCMyOEmAOns03nuO9zLkUvK
mIcT
=TNt1
-----END PGP SIGNATURE-----

tag v16.14
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:09 2021 +0100

rdma-core-16.14:

Updates from version 16.13
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzPscHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZPLCCACVyRAl+EpiE946kCFe
onxD26s/35bQHcg2GweinYoj8JM3KcxicUPgaOp32YCskUaDJbkkfiaxyov8PJZJ
WkRHpZoIKgnXotcaw4Nbx6mAYh1nhuc8V68OsDz/jnFkvhcJt52U9G2/dZ0Rwwez
vpnQJI9k7eP7Gl+00Xrcf3Pfys39qADvMrQeJ/DR/IaDGwowB+GsWlC05NRd1BTa
KIfc0SFr8qWVZclZOblc3MAMnpe7q5ovbIZgqOHNapg8EXBGzOrsRK/xu9QPAalL
bajrC8Q+YkIiFDykdm2Tvlgdljr6i9+0pCP0xWpM9yaMB1wWFaQWegRVYU9vsa3c
iw7l
=jtww
-----END PGP SIGNATURE-----

tag v17.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:15 2021 +0100

rdma-core-17.10:

Updates from version 17.9
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzQIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHdAB/9inEFjdgqLS5WcPMH/
mXxAyf2OnrnKLO0TVd4qnOzv0jMkPhOf4mn6bLE5/ZCYQdisGDLS1s3nolCNfFyV
VnypaEGij6EiI/TAVvOVCoqAKbP9xu+u+IT9yujdYMpV/meKf9vHtIP8qVezIVim
TIhu1G/+0fYq0FYc9+FM4/rwImmjwPM4FTLf65AQl/WoiQdr/f/yYV76ns+BFDGg
Qi+nDUDkuurCYiEroSgPQGnuL2iCLku226bJW9Xj8gAWfc1MyYqWWt6Tq+oWLYIA
8jmFTnSvwo+nfgatGe/kznlFifGW1dQzBzGwoViuzrNJNNuQZmpo36OPZjsz59TV
h2G2
=+UGq
-----END PGP SIGNATURE-----

tag v18.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:21 2021 +0100

rdma-core-18.9:

Updates from version 18.8
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzQccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZANpCACodjRiE0pBeU4AM85o
pcHIWMSuDkxyqGqjc4jkbhwQ9sOhiJh5ebbY0YcAvbNc/cH+42XfsRx+ckI6ueQK
It7sFvf7drcSS0gbH79ti2CO7YLKe/G7cf3tIA8o9gxlj45myzdDvz7mZDwtqBrW
/u5VF1bNPr205KVR4+Sl+mhitSHrUyyxA5MJeE5JOTfZpDn5iI7bJxXU0A95LcKN
CMQ2uHbitPBlLSeVjXOAHw3yif3PsA74b0gFMt8h65No0emChxZ3Fj9CD9Goe4/T
dsMgRClPNA/2/2vjwLY9sIFAv/obxiEsS5QMgXX2M2N1O9yugjdlDFKgQLgn/xCR
SSdB
=YU2K
-----END PGP SIGNATURE-----

tag v19.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:27 2021 +0100

rdma-core-19.8:

Updates from version 19.7
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzQ0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHfcCACf3+P+X6BMUOXIIB9i
yU/nw2A0YwS6V8K3ynaU26HYDb35jjeFCUtjprz3pVegiE9ZeQWio91EPChRQFPS
xTxxva9Fh0suLjnvGbmvefESfjTPgGxebyZN2M4fdFbtVdZy38/gedRN8+J+LgLZ
aB9uqz3eaXS/Dcbm3DtHFssJquLj/QowDQfMmyANwx3sTWh/Y4zPhyGG8lh79nMl
JJ7UxZEkMYVyg8iFGo1dg2uXj1x4gjzUMFvD+nGYWF9U3ZWKNlZqnvxjjkexpvhQ
3sUge7AtxK0ksi6KEUBPVR5SO+glEW8LonWYLDRpSZJrb+/Cy0yuKOLO17dTq2WP
Mb0m
=0rsV
-----END PGP SIGNATURE-----

tag v20.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:33 2021 +0100

rdma-core-20.8:

Updates from version 20.7
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzRMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNjdCACLt0KbaLL3Zbwx2e2p
KevJn+LmLvMWZe0RV9e60J4HmGTkxC3AVOxujShNtwWvEZpYdxlye4goz8dQwJvH
M2j3n72rod3x/jrjsqO+hibm1+tegg6JF1lFTVTCHKzpK8lkVZmFunh/mmJWDMx5
+niMVKCk9lUIFnhnP+NXeIJsR2TRDzH9JRzQ3tURmDhlmkXHH3rUKmltFr6kvVF4
Fh8qim1OAFu46jR3PfqKBQXq6nEvXNi8ic7zDUqxzerPBjxyRQkRiZEikkxaTgeJ
FcXSjmhQkNUyRJxcl+A3nSeaV94VzMIBSmFCJa1j3E5+HNUm6fA5sBV5t+ZhCLmp
nw/v
=VBco
-----END PGP SIGNATURE-----

tag v21.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:39 2021 +0100

rdma-core-21.7:

Updates from version 21.6
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzRkcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHTZB/4/Cnr3t9p/YblLgiDB
XCUsnpJOoYyNOq7hWR8MsmbBgLnOdRe8gmOPYcdWNW/D5XDWuionVpMulKg9UGty
/M9E2e7l4cuolHZtqLbfYkuLd0tznLFf62rVgQTH3qs/b7nZK3duqR53oOEE7MGm
WU9O6B20o0b/fJQtxJ2j0wOO39kqNlRyrxmiV+KhquOVUha8wyTsoCiYJzUknqNP
Wh/OvgsA8aUeSIKVq61Myuj1vzY51HLrfFLaREdRbKjUErIpzthwjSd+dm3WWwvk
QwlwP3lTWcdvhdU6r2DpkUniwr9HA+NRLdzdJImMUaejJUbMilkWZzz9wdG0VGo0
Uk3d
=Sh2r
-----END PGP SIGNATURE-----

tag v22.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:46 2021 +0100

rdma-core-22.8:

Updates from version 22.7
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzSEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZI2XB/9RPjoqnOSms2sjn2Ik
BBU/dHHskOAdfi1PHjzZrt+JARhpgssHnFYVkrm+OIu+cLRIUioy0Plp702N4V6j
wsQ6OdNIuDJ+HgO7TqjABUjmMG08UyuHg7CvigVYX4Wnk/xNyy5s2NQN4EEgMbXY
opldCnnE1qNKJrbowHSk5fTJMR46bp0XS+mlgsB/1hYR7aof1Ng/EbX77C35pU50
0TEJmL0Y1LQZOrdUeiOmO38WaWd0sWLcjH0RIOGPs1Rnv73acblGd9UqQsO7oV1Q
wGhyV8nVoQiQP8b+B9lx+PmMcsPQtjRj+YZqNk8rVmwP78vlpRgdR7t9hB6CY0va
OI4T
=oLjo
-----END PGP SIGNATURE-----

tag v23.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:53 2021 +0100

rdma-core-23.6:

Updates from version 23.5
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzSccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBMQB/4kwlFm8wYzbkbcfkbi
PjK7wLu1R7bnbYKnF3keSEL82SsHAGBuQCBdPEjaSY9/pTbxj6GE+Qe0PB0VGfuS
965YUGuUZQ0oN04QvExmW4LupNjFhD3b+AuwU8NDCWGTzF6XTxXjb1UVec3HeKr7
TDDOyTOKuVlmiskdrs0Z+rhAPt3ZFi/t1sHHLvLQX3CO/gDynX3F+G142UVrkWVQ
/lme2scyqyk+ed+KWjTDJdxsFgg7O5MlnGXsMsGxmizLCJw9h98aKahDRrOh3OUa
WUZWYbVm4G/bkffpWMQh7R1Rh2s8AmJ0eSI3gQLMp6wxh3ZGyEnyaCpi1L57/H89
DVp9
=bk1a
-----END PGP SIGNATURE-----

tag v24.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:04:58 2021 +0100

rdma-core-24.5:

Updates from version 24.4
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzSwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZH1TB/9kad9CuUbReLemTKPA
q7BHUJgD92Baeu3MsnaA/5x+OKunKbTqRZnaTr5Q4PH97zpuFfH6pPf5OlGj1AZr
7/sdGcYVz5L9JV5joG+1hnPPUDJGxKB9hodKpL68fkSLIXhq53H3OAwznM2gR9/7
Hi1tO906X+ipIuy1kdOk/nsWsAWoPrrGPoVg4Z+LEeZtL6sIaivC8kVkRSzNo3t6
eOF7ZJN6PBvWXh+ie93HgVq8CHSG2md6bcBX5Zbj22skCSKwUzcBqML1gzwsTngh
UW/wT3gGPsoAGQxJISOQzxAeqgv2L7IWAu/gCyCzBK2yStdK5DiBcvbWJkp4brGd
TtlI
=hPom
-----END PGP SIGNATURE-----

tag v25.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:03 2021 +0100

rdma-core-25.6:

Updates from version 25.5
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzTEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOqkB/4jdeF4QcOkYl5fa+94
MV5a0VOitY4X4LYFybwXDWFikmEdZyG45ShZkJTLnj03OJkLjH6mWN7MfubzcvRW
6WmsTuNTegunTfJlEMCo6YShg6dquYv2t+2cl9E6Hx8gMYXYzdzKLJkJWr3hztJa
3/GcM4JvN91mCW9rY8WbtcDOwnvQi/8OS5Hvpv0tb1H+pnmhT/DSpVUGlFkNzCip
pWDEZZTpjZol+1Dl2+L006paOR0nwDGLwp1wY8O64Ftq0PdRiBQDWNtgduMRkbOw
dXILEwdYDKTK37wQdRFRQODkXMZHlLPWBwVwSedPIvPLEO2w1V6HOyIY0ogqxMnm
SMt2
=jAZV
-----END PGP SIGNATURE-----

tag v26.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:09 2021 +0100

rdma-core-26.4:

Updates from version 26.3
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzTgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCalB/985nVe9x+SAo4BBjqL
8TVVVMjLRsZaKTTRTxmiibeO+p7LIiEhHfjSTGy1TehryvSoYWY9yMAPPaRtKQg3
32TwYWk8V0W+YysXgAeIPJpMRvAZU7KDfVSNUH5u24O0Kolz97qOIOtq8pphKlbf
R+wiUlrIxO/z/07AAEdIufN7r/g0XwWlfqw1dLBiMXAWELh2dyO9lXJhMAEgHZbG
nI+ZNoykiR8bag6n6DIe6gw49SbDbm+3Iqv2xtLWEVwBNDOBr5Gu5FQ9SKkNQKJI
R2cDR8IPOpANV0T2d45EJumx/W/EU4O9N3Y7U+SaKmcrygb1M24uVzC2t2IcLHFM
Gu6l
=8Ji5
-----END PGP SIGNATURE-----

tag v27.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:15 2021 +0100

rdma-core-27.3:

Updates from version 27.2
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzT4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNaJB/0ck7eQd6mt1AS326k1
oMeoWn7drHE3fSCMMlUclrxvOLVy7OgXie7Fjcfc0tqgEg1x6h9vdMWux1pLraLG
zBzbpHblPq7qx/JecSvKayGI2wpdAXE570l65ethNQWxaPVXtMEGahuIDxaeSMC2
jm17gza5sKumTVdyN1JkzNIxxUj82KHmf2fqc45AjVbqaB1nw28geZNAGn2WiFHZ
xfbT+Gwabt9e8fWI6l1iGKVYEtIEwd1OgLTrm2thRQOmKTtH+LdReq2XOZ4Ym6XI
OhGDgrgRYj/cM30bgVtcn7k9QVjluKsYDl+k6VnmWhHQQN1ajV+oUx3U3srfifrY
ZOfG
=ThwK
-----END PGP SIGNATURE-----

tag v28.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:45 2021 +0100

rdma-core-28.3:

Updates from version 28.2
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzVwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJElB/0Y2OUW/GGC0JbYXn0G
vOwn7iMzJKcWmaBXmbxmk+JvzI4b51S/XxodfG/D49I6Fh3sOyamUOBrqYkWZzNG
xemBISW3vaCsTDdg0WjoqX26disclwFe8w7tJ7bVkcNEzW/47XnOUc3AtxH5OMk3
iE9dAzVqVBD/cq03XywrLiHPHJ/Ea+i4J8Idld5297NSLLIddhz5PP6WDKrR3Avb
JdPKWOru8s59sIUqP6kOjZ7fbD/YM1YM/YJTpl7cuo+AqmeFTBCpg5fpU+V7rQ8u
Q2Oy0B69i8v8JF7sNmD0JGaY/DckQxCBtwPJD+Idf54K3PlTwCtqs8ZwIzWg4fWL
mdD8
=ceyO
-----END PGP SIGNATURE-----

tag v29.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:50 2021 +0100

rdma-core-29.2:

Updates from version 29.1
 * Backport fixes:
   * librdmacm: Don't overwrite errno returned from libibverbs
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * rdma_server: Add '-s' option in rdma_server's manual
   * mlx5: Consider single threaded mode for shared UAR
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: DR, Create NC UAR as default but fall-back to WC if failed
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzWAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBOEB/0Xj81KLNNvhcos6Jyg
fwzPCwi1kL+R20kE4J1QJS34iSCvlpaBIIpSKpuNu1UXV4S/A5AFXcZz1xg4xvjZ
B7nu5keHwk3yHNcUy7RR7d5SsR5HgalMKA18Fc8a0Qet2lYTj6vREz4hmw9MGRl1
JDBwDr8Uzp8EkIF9R+mTVPg0APzGZrB4ic1U+WgekAAL14qFsT7nDLMWaSx3WEXy
qhFCZVZb+hDqirj0sXxtfntIH+ItqmPiPmd9EshKdYA6Gpk7kMWyyngwRNOtVigc
DUeL74Hjw1qAURgmr+SgBfYqiv8yqoDP325QM2mYd8g6/n4yonBlCTIoHubGqv+W
nyPd
=yimy
-----END PGP SIGNATURE-----

tag v30.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:05:54 2021 +0100

rdma-core-30.2:

Updates from version 30.1
 * Backport fixes:
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * librdmacm: Don't overwrite errno returned from libibverbs
   * rdma_server: Add '-s' option in rdma_server's manual
   * mlx5: Consider single threaded mode for shared UAR
   * udaddy: Fix create_reply_ah error flow
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: DR, Create NC UAR as default but fall-back to WC if failed
   * mlx5: Fix wqe size parameter in wqe signature calculation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzWQcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZAVLB/9CtxDJls0PT+iP3n0Z
uXsoRTsyc+QRYofnfcYmIkd/6wo31lPWZ2aBY7Fxqd/FY0Klz2mfNuRrIn7QEKZ9
nubojzmepRZ3lkmdbrluYp1XSXrLIuWDw2BnsoaLCz14R2oXg2jYagD4HkwoVnqL
PKwvgOtMzg04AbVRlUlJseBLeDfjaxHIimfxys5uSHntoRfyOiuNRK9+YWmfZDQ3
3x3LF08hjj6bfAGnrkzBI9KwB+JL993A++S/ieke23VkenHDJQeNurU6GHbIhNWZ
gyKJ2jKdnmmOYnavCCus3v2Y9/4RdtX708yPgQvWZaPIyNLVzudTm7WPPH20XIUc
WV+9
=/Ss+
-----END PGP SIGNATURE-----

tag v31.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:06:00 2021 +0100

rdma-core-31.3:

Updates from version 31.2
 * Backport fixes:
   * srp_daemon: Fix systemd dependency
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * librdmacm: Don't overwrite errno returned from libibverbs
   * rdma_server: Add '-s' option in rdma_server's manual
   * mlx5: Consider single threaded mode for shared UAR
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzWocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDyyB/4t0xHyVhpPs71ADFmS
yzLmnKtpGuqsSGkj6S6eqSnrvNmzWv9uRDQN7p0GW98RnLK3UuG9Fg6ollTXsVrd
FTSnpe7nA6qh7p5peqQ4OHZwUgefEd6uvF89y8E5bS/ODWMbZRNibfAHOe6ddhBP
EO+Y8QQPsvaTBBO0EAROcQt39gzLAOyjvZGMop+dXZ68wX4U+npJ/sEN1FWz7yVs
Hvi4OVU5GxEldx+Dwt85yHxC+bXZGNrELtVUvxi5fTc5u7U/uWH2IeIhfcg3zXeg
Wt6Gu2kqZ1i9DWd6Lb+SRO1YOdqDGf5cpCCGCTgU2CqsLbWapYpTmYhuqJSBTwOJ
u54+
=j5uQ
-----END PGP SIGNATURE-----

tag v32.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:06:05 2021 +0100

rdma-core-32.1:

Updates from version 32.0
 * Backport fixes:
   * srp_daemon: Fix systemd dependency
   * mlx5: DR, Avoid ICM depletion on multiple domains
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * librdmacm: Don't overwrite errno returned from libibverbs
   * rdma_server: Add '-s' option in rdma_server's manual
   * mlx5: Consider single threaded mode for shared UAR
   * libqedr: Set XRC functions only in RoCE mode
   * qedr: fix USE_AFTER_FREE issue
   * udaddy: Fix create_reply_ah error flow
   * efa: Flush write combining writes before writing to the LLQ
   * redhat: no need to recursively remove srp_daemon.sh
   * mlx5: DR, Create NC UAR as default but fall-back to WC if failed
   * mlx5: DR, Fix incorrect use of fl_roce_enabled capability
   * mlx5: Fix wqe size parameter in wqe signature calculation
   * Fix cmd_fd leak in mlx5_alloc_context
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzW8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDgKB/sESYNwPvEPMoLRVII1
vHrF3KyqiXyA6H7eUtLjbs1xZ2joiZnnm1G+8D/JUOX1s0vVoM5JLuznmtR8derr
Dg8yuZpByMRC3sQ0hF9n4zF9z2uvXsN+Bg8t0kkHOHHTtPbe1hqjtyNoYLNJ41tK
XDP5b2kibKb7UdhGxysV5pklI5kRiPV8MgheXiE+Dc2uboWaNJY/ivs9OgLQJ822
fkRsFhopGAfdZPCfJeVulxSIJ9bvyKZ7Z232WisSdrnJugMdkbadcsDQ64xORTU/
9LuiHjX1xkpHRPkXovmFU4rCPFbHtGZgub4PsqdtWF5olnX4i2jAt830ImnV8OeD
4Mlr
=z45/
-----END PGP SIGNATURE-----

tag v33.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Jan 26 09:06:12 2021 +0100

rdma-core-33.1:

Updates from version 33.0
 * Backport fixes:
   * srp_daemon: Fix systemd dependency
   * mlx5: DR, Avoid ICM depletion on multiple domains
   * mlx5: DR, Fix incorrect last STE update during rehash
   * bnxt_re: Fix reported error code from create_cq
   * verbs: Replace SQ with RQ in max_recv_sge's documents
   * verbs: Update the type of some variables in documents
   * tests: Check CQE compression cap before using it
   * cxgb4: Fix reported error code from create_cq
   * libqedr: Fix reported error code from create_cq
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmAPzXYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKegB/9waFthDtpZmvLVLKMV
8oQr2S/kWAwt+x2BCBqQ49GplqKr+1HSwVOU4/zcnquD1fWD9PQ3mNOkU4tNv5mo
SaNglDB2hHxY/vTzRK+kO5MuciyCTzkdVA1PKkUEVgJ80n4Bkt2kOg39/cbEBi3e
1S1V5KelIpN1rRn1MKXPrhBNfImNo0ZPJ4KrDaPu83DRd5UN3I8FlxPDF6Rbd0MB
3BD/4TgiU4hF8YtShWh0F9iTDFM+arDIqnhqUdMQBLj97azQh2+ASXxXts8YohTx
0ZVqqMZWswEYeysWYez4uDBDoTr0wIRn2tSGwI3SCCXRsXsytmeB9XgoFwVPRcSB
/OMq
=tCxJ
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

