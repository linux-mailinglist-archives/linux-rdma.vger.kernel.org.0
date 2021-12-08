Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D186146D247
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 12:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhLHLi5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 06:38:57 -0500
Received: from mail-dm6nam12on2123.outbound.protection.outlook.com ([40.107.243.123]:58592
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229573AbhLHLi5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 06:38:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+aDq4KLG0zGUz7hNEbW67KfwySv2XmI2VOQsFvBdxOJbVJeAhUK6UXoxZtk8gA6tjbmj39+GzfGZvd9wWyhR+isyC6xGW1xn1nZ0rdR5KRM8qv8+Y7+0VMGKNP+Eoe80mjmm3z9lA/gGkeMm5s0NCkhv64F/rXo8wbMYF3mgQUILcdVkuwn9rgjmGNb+Jf5Q1wbyRsrIkuqzLTMEVHjDVvejgm3F29/AMgemHqV0VSRJXusw5EIwv0WCAqLOhZsoGPhvhOETDIxhtORyjWkap13lurEAYA6vvokaA9isMlLQqrlACZFjLHTADOEVAH1KspTvOEy7a/k6c+8ABLwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4/A1fCEsZ0dNPj8a2oxVrz+kp+pwym1wzX6KyR4wOg=;
 b=kTjb3BI0A3JLkZSkuJaQAdymRfNLEel568NZx5luw4YRYM4nb25T2XF/95EXYRciuuSDg/hWm4H/ndWzuu24oAd66Zf1EgTkoJ2IbOAHwLovJRMAjKz90kU17r1O2Mj4vgQQ4GO0K9u/hnTh0+bRInvwwHmlJHLj8ndQiCVBgnCIDB5PpG6BXRJNmCSgLLTiA6F5i2FU+aK1EkLAm3+0fIyxzkQOWADrC7+umamgTKhhydvXoJ+p30kcjB29g3Q+CWEQLY/PIP8OtrPjb/pPjZ5gpPR4C1jG8qFMYw+/ZlF8XIpVaGG4ccngCwvVdjC4fL37I2fy83ak3mHZ3B/21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4/A1fCEsZ0dNPj8a2oxVrz+kp+pwym1wzX6KyR4wOg=;
 b=BeM5uLWH6Vc2GRYaSrquYwuxNW0IJHpdUemUUxaAmk04l4a8EOW7DjFYRwSxF4R1NLWjZSob/WMoaIHFqR6zJIiBUjxcbScInet+sZzBOWG2sRILKfPklpk6VghXxw74f5ml6Upnu4ByoVSmcatuytX8/mFupsin9XVHeJ6uZEhJyPqXXmZE4o3ZRKZHLxKtNbv1jnFZ9IKxo6E0ZauEDtqgJZnzWJldk2f5qpM8OWSVILc/v2NByWr2hlbN3YjceO3L+5c6AAXtZlPiaXcQ+r1U67O28kiGI1PNEPbsRCGMx6ZnHR27SpwQze9fJoKLUGaoi/19nwf4V0phlkRKUQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6987.prod.exchangelabs.com (2603:10b6:610:108::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 11:35:21 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::2114:506b:1266:f823]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::2114:506b:1266:f823%6]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 11:35:20 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Issue with rcu_read_lock and CONFIG_PREEMPT_RCU
Thread-Topic: Issue with rcu_read_lock and CONFIG_PREEMPT_RCU
Thread-Index: AdfsJq8wCEInTfQFSzSfnl9OoxKArg==
Date:   Wed, 8 Dec 2021 11:35:20 +0000
Message-ID: <CH0PR01MB71536FB1BD5ECF16E65CB3BFF26F9@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9251cd3b-d6c9-46c8-a5dd-08d9ba3ed130
x-ms-traffictypediagnostic: CH0PR01MB6987:EE_
x-microsoft-antispam-prvs: <CH0PR01MB6987921F0ABFA31D82CC1C56F26F9@CH0PR01MB6987.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8SW/JzS1nNvwrNUYztI3d1/VuP5k9VD/H8Xy7+ETSIQ1HchhpHKApbd7mR09T3HkIhOfk9HhmLVxekLMi5vvJ2UAZVpfDVdOczcQ4cE+vJAoiojBiQJfECHuAkobUl5QQvEj2HXDQCdumW/wggzjWy277v/rm1wjiCfbsGHYExeDPG0O6d2EVGAKXv8p9k1RwcMygbh0t7HKDdFPkLD+spWsHLBvEEshUld//5JBNpqFnDwXMrRK+OzDLAMmQPMi23sSyxrZ58p+S/eBZx52B6IwvaH2nXm9S7UaXO1Sy5GZzREn1m9UCgv6Yn/BQMuTCL4VzjDRGEaLRqC2GxU8Nlh7tfDMi9hicHyx4EN6BhPol1MG/FEyIffJumz118WCJsl7UHeQYL6sfI8v721tQvXXF0mFHO5aUwFVMQpACYM7R/pxNIsBwVWIVWAtDyt4CjAeflRBj2ITT1UPkaLDQr2XPYO0JMxM9GngeBV3WxN5VI5otaLn84F2Ln/69wLRD8PcPAknu9BeJ/PpG0ostInCCiKdXboMUfvGcu55NOyPCNxA7pdukwFyGUq5UL6LYd0RONK9I1YORXBVCo0FrU4wewEyjNZv5SxjBTbaWYaxF8RoHnPxc+pymGYT9/T5TAaAhclRo4c3eDb9JkkgjCB11IJy5RbfswvKGzQ26+0H+3UAWOCbU1eZx61iubY8MPlQg19VUBjUky7FEwty3B+QMQGxCnzGsowbXm0EysAjp0FrtQl1gXJ0gYLLJCQ91wa/dKx7gucjGFBNP/A21Iq71DQAuj02O1P/6I69BDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39840400004)(396003)(376002)(186003)(52536014)(66446008)(4326008)(66476007)(66946007)(66556008)(64756008)(33656002)(76116006)(83380400001)(107886003)(8676002)(2906002)(38100700002)(55016003)(86362001)(8936002)(9686003)(7696005)(71200400001)(38070700005)(26005)(6506007)(508600001)(122000001)(110136005)(316002)(54906003)(5660300002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RB1AlR/D0leYGG2f7sbivA1aJTx741I5rs4L+1QNwfVlaq73BhxiSDsuJnEK?=
 =?us-ascii?Q?/NQyUOjFGEyoKWGF+5xPtq2wIKJdKGJGtX7KI180OdP97mRuON73oYg8iJIQ?=
 =?us-ascii?Q?paRXqZga+mynNxvCKcZ+4ntItrovyXBlRrX4vXBbfSB3i5uZGH9SXFdUGsPS?=
 =?us-ascii?Q?mS+1uZGY4R2GDd6BvCxpkKRW4XHHXyLk0jkQuH7ZcayVCeN09FQiYMCNIMkT?=
 =?us-ascii?Q?RFIpVLkdk1XHECWh+e0IVPmOJPPAxORDJMeN2GiJZPmRBq3QxFYNz+AePxJo?=
 =?us-ascii?Q?g73++0Dq0JXiHwBbdDzAMaUt0f9jfMPnkVWxhKOuoxpkitcBBmF5ifD76883?=
 =?us-ascii?Q?f6HuAz4LN931sUGaaVDrlCsJmQaZGDTtjD85YDV19SnrVolGzhkgI0oxdt5Z?=
 =?us-ascii?Q?gc463ORfOxgDh0qe4wrOguX4bTanyllsE/z71mghpArnseH0yTS/wAth71+c?=
 =?us-ascii?Q?ABCZF9dqD7wWcDKfvaOx4VCewMErnFxcUCu9yDg/DIek7ewMz9gFZvZgOAyN?=
 =?us-ascii?Q?gSeDAuNbmAttoKiKN653WEEcVBJs9h/LW6sK4lAEsJejCf2fEZnil4x/fPCY?=
 =?us-ascii?Q?qhKxjeONtBX+XXLRuhFn7ymjJZcqSPvQtcKvD0kmgJYlgE/JxIU0h30svAHi?=
 =?us-ascii?Q?P/fmgbcOdv0pAtce3CGCmLSXOVnAbcX/9uPOsl9wz+bF7x3PZDu5ljbdImRU?=
 =?us-ascii?Q?TlmZgmHCWiSOd4RD0NgY2BUZ+v1SETXH+5kjOqIutheZ+f327+pGosVugl+e?=
 =?us-ascii?Q?s6A+HhLg9F3PjZyHMsHE/4Ym5j4HE4XkmLfodNSp1Tdjg5+3Giu59hj5gspD?=
 =?us-ascii?Q?7Q1M9/d5IcLq1fVs/OYnfatYTcte5FNzjB/fkmP3nQ6z69TMdY6m2zXQtLIU?=
 =?us-ascii?Q?Z+geY6/UbklooLRRVy+p2Th0ZHqwdZLcmxCSCa6U6zLXAuMFXYLOXGbrVeqw?=
 =?us-ascii?Q?RuyxUoC8ek/EDDz1U/MbTApmPky5wVEZIoduGSGSTRL7jx/f5wW/9FB50jhF?=
 =?us-ascii?Q?AGm6pqKVbiiuan+BSQMFq4YVpaBE+9zEe8wLmJllWA1sWkzar90SxLoMwwMc?=
 =?us-ascii?Q?xxxhXsuJAOmrUeHKuxLtm7EjJCzKx+0qDy6Gk0LmdNNuT+EkuXQ76WIsVbru?=
 =?us-ascii?Q?bgcdrn1jn8E9p7Ykf5YiSleXsk7ItPq1EurYRzlDSjXEoREcsyo9E7f8OISq?=
 =?us-ascii?Q?V0xgTSN8tOxcka/1WcE1hCBixX+oxLmdxGpMOS7ddgebzM336rDSkLO+J0zt?=
 =?us-ascii?Q?+hVcljXrDrQW2QFXX65QJFAoPJ8TcwnfKysADbc+LxGrbVitHF+fCyW0O4Fm?=
 =?us-ascii?Q?zRy/N3KxTVSvmELKqE2MCDdJTH/XAB/6bDKSjFJIBbHvxxdp7jWthnp67v3u?=
 =?us-ascii?Q?xdpdXj2EgJo9C+mX8Lkqff4nydYQws/VN4EjosqqffgcnIYQjTEtjWY5MKjO?=
 =?us-ascii?Q?d7a3SJt2MdobZkVklPqeBFN6KmfogYlJFs7xmnvqkmZVHkh7rfdFV34J3Uu8?=
 =?us-ascii?Q?8STG/xVJ+PYftX3e9HcTg3tsOtS9dHiNd9IB65WY+8R93xElMBiIna5pOEv7?=
 =?us-ascii?Q?FCNBSDQGO6dff4h/K//fLS0YySs7YbrV524Tm9S5Mxsp/DTG3ppi54ElqAbD?=
 =?us-ascii?Q?TbvhPaZA49HuRxC1IhxoUQOy85mx/EXAnJ2kznZgfpGuV4Nhw/Gjw4ccdzqZ?=
 =?us-ascii?Q?yrP2qOHrzsGPQH1Fyd9D74H4SI1vkJ1PEv8qXzz0u3Q2ewoK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251cd3b-d6c9-46c8-a5dd-08d9ba3ed130
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 11:35:20.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YeN4WiZcSXSh5QiTbFVrnDti1cUvsssmwVYBxudxkfppsEAMUUWmMU+ff3OQ1qxBvsZj7V6FcoCsnDe06DBRfCz8Gg4JN3yPmIr4s6qll6u8kHtRboURF1BkxBfFsvS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6987
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As part of testing the 5.16 rc series we noticed a new BUG message originat=
ing from check_preemption_disabled().

We submitted a patch to move a call to smp_processor_id() into an rcu criti=
cal section within the same function.

See https://lore.kernel.org/linux-rdma/20211129191958.101968.87329.stgit@aw=
fm-01.cornelisnetworks.com/T/#u.

Much to my surprise, additional testing still sees the BUG!

Additional testing has shown that an explicit preempt_disable()/preempt_ena=
ble() silences the warning when placed around the RCU critical section.

The RCU config is:

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
CONFIG_PREEMPT_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU_GENERIC=3Dy
CONFIG_TASKS_RCU=3Dy
CONFIG_TASKS_RUDE_RCU=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_NOCB_CPU=3Dy
# end of RCU Subsystem


It looks like there is a difference between the checking in check_preemptio=
n_disabled() and the implicit preemption disabling in __rcu_read_lock().

The implicit disable looks like:

static void rcu_preempt_read_enter(void)
{
        WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_r=
ead_lock_nesting) + 1);
}

The checking code uses the x86 define preempt_count():

static __always_inline void __preempt_count_add(int val)
{
        raw_cpu_add_4(__preempt_count, val);
}

An explicit disable uses this x86 code:

static __always_inline void __preempt_count_add(int val)
{
        raw_cpu_add_4(__preempt_count, val);
}

The difference seems to be the use of __preempt_count vs. rcu_read_lock_nes=
ting.

This can't be good...

Mike
