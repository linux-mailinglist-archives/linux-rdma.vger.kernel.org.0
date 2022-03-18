Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0924DDB1D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiCROBC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiCROBA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 10:01:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2012.outbound.protection.outlook.com [40.92.52.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE7B1B3083
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 06:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhjN8OyuYEpkoxhVXy2LwLoTBf8RPXcVDVcMpCLT/OM8OaJ0PSNnMgHJQHJIwX0NGLbY43veoPSr3OJk6s/SJxFSTXPDmfqHiFdQZilkJLEZbmyNHm7QEqGr4pf9fQUfHeNJtyGwo5Jn2ort9xQLBVpZymBnmJQ1iUdRgNz7G8TOOomMEPO8VEAE1blkSYuenBslEeRK0MaeTRdEOtbohyswht44KNKTUrrS6rgHffxE1phhi4moI15hDp4okMU0gTc44DJ/Ydr2o93VwOnz2icB88Y9HmgB0xL/et/RuaIrS+OY8h2njK0Mzrl47ZBpzHaFIzYz8e1swaOg9eoOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fxzcbZN602tpOF2gvrx7ecujzyDpNRhSrKEK5GWdzo=;
 b=At0zQHGovRkdQ6fIN9L/Q7pETK+l/C2d6J0Ui9yKb8I1PnyS5tbQQ032bMOCBI3BMMp4JzL3vyPddtxtuCDuGk1SsmCy4aqIzqVQfz+xqYb5qrwp6XlKH43kDWMsRuJQLCZVzASASPb2ZRUOdAt1FVgo3cW0YmoJGgV7ypsGg9FTBDm7Ty/FsLGuVEWkK0i8L56y58jmHgfkNtxoqti1IGSBolDHoq7mxCUSnw/lQs6T+kd1cIPV7do9XSkYdpcnR7GGiiX4ubZ1zwSNRLm6krgSnpVL0kahR8t7AlpV+AjGaaeUxwO7Y1+Oh1RQVfBXyui5l0HvDSthWjV9UhkKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fxzcbZN602tpOF2gvrx7ecujzyDpNRhSrKEK5GWdzo=;
 b=mgJ1gbTen7RH/kx9mPF9+4UVEMqSSc+ifE6gTZjIARpCVxQze2bQLiW7wwN6ZGu0jm0oMRCRcHT4XRI9+/jIQsdwDQ8FuCclTsjbLnELmhYKqFEvxL7xcm4G7KsZHAdQT+qZhctGUjEoXYR3J12MaoS4Q8TJX2/5lmAFU/XDPp5PqkRs7PfYVg0DkHv+fVyu6CAzC5bx+5SwtkznoB7Mk8BxitFQBiuQgq8tkGeMAeFbdgoi7qGy/ZCFxdPnYgJQrxArXJzHmfI6o8GeJitA/0Y/kwt3PmHZDT3/HZdqwksg5v4k7Hkw3+Fzxu4IP6rjklcvYCWPn102jRw3jOLHiw==
Received: from SI2PR06MB5242.apcprd06.prod.outlook.com (2603:1096:4:1e2::14)
 by SEZPR06MB5023.apcprd06.prod.outlook.com (2603:1096:101:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 13:59:38 +0000
Received: from SI2PR06MB5242.apcprd06.prod.outlook.com
 ([fe80::c0c5:a53d:9869:5ece]) by SI2PR06MB5242.apcprd06.prod.outlook.com
 ([fe80::c0c5:a53d:9869:5ece%9]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 13:59:37 +0000
Date:   Fri, 18 Mar 2022 21:59:30 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     linux-rdma@vger.kernel.org
Subject: ifdown/up one slave port under RoCE LAG
Message-ID: <SI2PR06MB5242C1D26CEAF1AF760FCB32FE139@SI2PR06MB5242.apcprd06.prod.outlook.com>
Reply-To: Changcheng Liu <changcheng.liu@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [qKMM3YhlaVfS6Nqb0E9lJis7lkg/8QJ7]
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To SI2PR06MB5242.apcprd06.prod.outlook.com (2603:1096:4:1e2::14)
X-Microsoft-Original-Message-ID: <YjSQQuDky1mQLT7Q@gen-l-vrt-307.mtl.labs.mlnx>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c85a9018-76a3-4dfc-5b89-08da08e78a01
X-MS-TrafficTypeDiagnostic: SEZPR06MB5023:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gr4mC2BZmZZ1e/rlmsl56w6TrS+MUCfsH/QSYtirxOCUtX+F3QKnEfRoyZRlQ5NIcfcGtFCNBPg07eDh2ojAcGpA2K1lfKUNhsIGbbq0eFoMVS+4rAQzh9xtbIS/Ahh5akaI6+6JNf9sNN0dCc85y0mf9zOhdOC2xDl5ptl1/OmVedj2qztfjUG6/Nnulexc3LInJCygmBhZucyVj9TdERj9Upvj+Yh+I0U5ctPBuWWx+iQHy1uH3eKFCTKYc130zzvyTKUKu02zXI0SBHMaNvO6x66AbA89JxPWCkVUjYLM2UfDCt/w8V9gldJ9S1cQQavl6CMQlYSQdPTnvY8uKQqazc8Vt62DVLoNj0gvrmN7zLPXeHpmYt4mRMQhaEex6yifqM3E/MRes15WnboFxs1Dx7x+orwSDTzEJxxLHT7VITwSzMr21COqCgG44Ta1ld3pFwi5XA+w61YmY+oYl1EmdM1vAjr5hHka0Gj0keL1uP1IsUDa28ezkLweQRN6+0p7GjVo4rRGrWkjGOpW6bKv3qtZuojYmeGceQM5yv2LUhalXOOsi+EYKXo+Mt5WTxxwQhg0Hkj9s6bNUsfBA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XoSHhX13vnvL2upXaKIlBTOA7DvoTtmBJ4HzdDv+wZ/s9cmNUGZiOre6muve?=
 =?us-ascii?Q?qITcHj7t7WV1z+NLv3QRYDhb+8tkqUqmQUajsYPmv9ohs17/TlW69JTnlzHU?=
 =?us-ascii?Q?oplLIjWlzfWA3oWchSzCS8qnVYdq4MvDAdmY+yQmGCWGkZpjaAUcPj2NkMmF?=
 =?us-ascii?Q?S6YveRCKc9IE6sC3jZ5WU1u+i9YHmJ/eAhaBaynk6Ra7Zh+tnlkaHHATG7GW?=
 =?us-ascii?Q?0RBtfeUS/tNcbPpap7T1fH0WdIWnHTJ7QC2KLY3Sl+TZ40qEWNPg6bZpD9b9?=
 =?us-ascii?Q?QTyQnUxPfy9ilhIs9dtUUrv6NeJ+8HWT+j9yP/Dj8mdZgCBKaEQSIa/EErAu?=
 =?us-ascii?Q?zbihpZCAmU9ncoR6yoIL1UtAtiaVZjfBDJkFZPfyPmlWMopLxbCfKOomJkhc?=
 =?us-ascii?Q?KqN7DA9yMwCCBJ3vp2/r0OxokDFIdWSvOqTLxbFz/z7NHO18vNLVhIERub/P?=
 =?us-ascii?Q?G48HiARXknxxOht0oUVhCvC/1cS4dub9riMrD3N/Dhc5lw527nd/vW+bt6+y?=
 =?us-ascii?Q?7JO84UrFMaznstwAvWKBxS51m2CP/AhL/fx9VheNWmjTd7gWXuD0rCPaypLs?=
 =?us-ascii?Q?pcWd6eYRqo3suj2IJhzmWbi+PER3FggcdEO0PAoPBnQTIAlhjUzLHSlpVybE?=
 =?us-ascii?Q?qylf4CXkn7SKXOy7xdGxnB6MsEw8kg4yFa534vBQsGHSpu6aoZ/TrUtlr1mS?=
 =?us-ascii?Q?mgiDMNBmiLnGzQCcoOd1Kg3JW8la+6X+s8a0G8Hh8/WZK0SIQRk7VC03PmF+?=
 =?us-ascii?Q?BlhrubmCHiwyp0xX0OD/VO0bd3DRHsWhdkO1AOdB5K7d5VWvQnKpyEEA+wIP?=
 =?us-ascii?Q?vBpTv6R5MFsTpBsQ1od/kxG/Zv6yvQFwt74Eg9WkGacOhqztQUxdjeNqjS04?=
 =?us-ascii?Q?ZppgFfEAnAccdZXbeM1HFgepbTWCdf5UWy4IZ82APpQIq45raCcNbO9HRVtC?=
 =?us-ascii?Q?tRADE+rWDtlrbIqIR8ClV9GBxG25kU04nyz/Ywl5xDHERTKhgbvPyxo3igcb?=
 =?us-ascii?Q?Ewn42kHwMCq64q2SE+HifAT5YVgOC7MDqSQsfWd3pfqBopS0RXm/uPuRiE9v?=
 =?us-ascii?Q?Ts0y9q0xStwtAQYYmp/gOP0HElxN0gdQl+mEi6Pi8UCyrFUgS1H4uY/1g8re?=
 =?us-ascii?Q?yL8A9wm8yRaaGD4MgiwJ5lElUfgCv60mP5VNiGPS/5yc96bpbxWy6pk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85a9018-76a3-4dfc-5b89-08da08e78a01
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5242.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 13:59:37.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5023
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
    Is it expected to get RDMA_CM_EVENT_DEVICE_REMOVAL event when "ifdown or ifup" one slave port under RoCE LAG(802.3ad) mode?
    I'm using mellanox RNIC and configured them into RoCE LAG mode. Then, I created two RC QPs on the client node and establish connection with another two RC QPs on the server node. When executing "ifdown" on one slave port in the server node, the rdma_event_channel(in server process) will receive RDMA_CM_EVENT_DEVICE_REMOVAL and the ibv_context(in server process) will get "IBV_EVENT_DEVICE_FATAL" & "IBV_EVENT_GID_CHANGE" event.

B.R.
Changcheng
