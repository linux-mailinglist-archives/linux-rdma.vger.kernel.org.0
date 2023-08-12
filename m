Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883EB77A11D
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Aug 2023 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjHLQk7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 12 Aug 2023 12:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHLQk6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Aug 2023 12:40:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2114.outbound.protection.outlook.com [40.107.100.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D571704
        for <linux-rdma@vger.kernel.org>; Sat, 12 Aug 2023 09:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egnDO166xbV4GSz7MAOZPuwVe7vVJnjl12fl9i3wkAok6FkDypdS95Yer2H3Ge5hGAdQtRwLVm/9BvPGo3xBk3iQeQ3kWwwYBUDKqHdJbJ599UaVNdtBy94P3iB/Rl58M7LQLZMe6kixdLhybz9/Db1DvJfk3spnThaMtfv4tQsVYvQUcSq/CGxSKH2eYYyN/L4uZNNKddUiDmG93lpWX6qM2SJW5zbMHtIiB49SbNEPnnFUyGPXK9kOW2y0q+1E4zmX5MdOpWW3V5K52z28TuUlvjwU0Z0ERgAAxxu3JQJjqSyADk7dmFR/D+CUByzrftXhN7wxEyRcQy7KjH34Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kpIbgdNSvu4rGz+GYOuxwg4sdXIb3XAaOhlfluaA64=;
 b=S/ZmvG2y0xTGftTBDnnromkDYHzTDmBhP/Z6IygubO5NZA20t+x8HHBy4M52Nc8aJmtYHEEIdpvc/Kvk7i6XRSHQW/jnYlyFkO7CM+jzY0rLuSRFH+fSCLfX7AOAlgIGzFcAFFjmX01NrCXymQNB+gdoVgAhTaNPLvF7UeUH1oUcTfYrS5CM8MTBXIcWYjgoRJj9TZPBEjO65z864a/FP8CaI2q/0dyDz6vl88AvGscV4he5REGI+AkcbWGOzs51P0t+P2o2Z/dVWbWEuFdswgjqmKANNoSeSLizQ1Vx9B6tlzrKUkibTZFgt+cw0dc8xoyK6Y9ge5/RH1k3Oi1nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiomdatascience.com; dmarc=pass action=none
 header.from=axiomdatascience.com; dkim=pass header.d=axiomdatascience.com;
 arc=none
Received: from MW5PR07MB9332.namprd07.prod.outlook.com (2603:10b6:303:1c7::7)
 by PH0PR07MB8703.namprd07.prod.outlook.com (2603:10b6:510:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sat, 12 Aug
 2023 16:40:57 +0000
Received: from MW5PR07MB9332.namprd07.prod.outlook.com
 ([fe80::6d38:e35:1c33:698a]) by MW5PR07MB9332.namprd07.prod.outlook.com
 ([fe80::6d38:e35:1c33:698a%4]) with mapi id 15.20.6678.023; Sat, 12 Aug 2023
 16:40:57 +0000
From:   "St Savage, Shane" <Shane@axiomdatascience.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Thread-Topic: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Thread-Index: AQHZzTu1BhHHdoJ4Yka+53ODy3oFIQ==
Date:   Sat, 12 Aug 2023 16:40:57 +0000
Message-ID: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiomdatascience.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR07MB9332:EE_|PH0PR07MB8703:EE_
x-ms-office365-filtering-correlation-id: 0b6ae661-4680-47ff-2f44-08db9b52e72d
x-tt-fromtti: TtTTITenantOutgoingMail
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmPAZTCwH39p2xq8REka35Kje3+7Xx16M8sScrx0uqyJovKrnvGaSiikFuNkkplxLA7dPAyARMoxKzTH/nK0LVoJHBcsNcd0c9MwjkMKopqUM27Mn/fR53iT6YZLpkoMcUiWdf9YRVQWtmZISbvI1Xb1qTyREhoqbbKxIb6QVYsOHCGM5Ju78Bo4VrpQiyRGBmmARInRbEPeKg5HFzEQheaUpZFQeQDT9108I8BFMMrl4HSBk2frNcWF9XtauBvmB5+/V4/Mu3guMtDLPetNATar86g/oxQJwlcKaJlctdEcTqn/IfDyYJWPDNX0WFEma6ivlDMpjbMpOSKOgWm7wag+2+vwqEgssCxt8FuDkNypPOgeurC9ne10De4glvD76UDn9hTb4IgYT5/on5Q3rKFrIiWDmiI87wNCBXML6vCUPhjtuQPDEpKCQRPquCGmTt/tekc7j/rf7NSESbq3aTBEETWY0zKN7VtEHV1Ntnw4RBe12Pd2GZFgYYDrX+rhmVt3KP3rWnpteweYm83v/4UpRU51r7QG9mQGZkZb1Ys1oHoQDI9Y9+mUiHPX8vOlVrURuuLA83C9eot8AuJrxuPgDu3K5VqZ7V6SZaDVsP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR07MB9332.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(39860400002)(136003)(186006)(1800799006)(451199021)(2906002)(4744005)(33656002)(86362001)(5660300002)(52536014)(38100700002)(38070700005)(122000001)(8676002)(8936002)(55016003)(41300700001)(66446008)(316002)(64756008)(6916009)(66476007)(66556008)(66946007)(76116006)(26005)(9686003)(7696005)(6506007)(71200400001)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p3RmLslx+Zy/FMXujKHJH58OU7xj+QKjCwjA9daKAPuZ+Rp9zjGho7a/3K?=
 =?iso-8859-1?Q?znM7ju9OAIvosdgSYBlNNXLfCxWggmZ9cOf222HF55zazIWkhjJMwWOHWp?=
 =?iso-8859-1?Q?eAxdWjeyaVdAAlGtX5dmRpvkmoIxD3xudeJfbKB4WlI1bsLGXpi/Cd4fCy?=
 =?iso-8859-1?Q?Dex6vhJmm4hRAiQPskTh9CuDgVaNA0nWVlrmgge4wJNn6Q9+HeUh+BCIRO?=
 =?iso-8859-1?Q?cSsdgwrNv0o5nEuihJz6cmYX1D9YZ5CSMX4K1rVfCxw3wZi70oFNMh6TUS?=
 =?iso-8859-1?Q?HiT+5T3e/Z6Vw8vHPSbxgYj1+iFE6y/AIQMVtJ2LM9UqfsCilsG4ymz8i1?=
 =?iso-8859-1?Q?yGpkGsYOIdv9Lbi+rV6v8fl9xa13c3GVLMI8KVqTuPnfe9wUr5bO56OV4h?=
 =?iso-8859-1?Q?DkWzIdbaarQbtEe55BoDS9AiP15wmoAU3phuiIe6VZOfL1C6I5dP5p0Q09?=
 =?iso-8859-1?Q?O5/7iINrWOXQNW7hZWldIkLfw6X6QAC1FxXq7822WGgYKsItdbTsYV1awZ?=
 =?iso-8859-1?Q?ds/kMfpEt5bI2D6rLxjo54ctmLG29FdtPOptyEZqdN/adxu//Qfgl8IegV?=
 =?iso-8859-1?Q?H/mijaPr04pgHHuyfdPWCLG9Ga7NuVFJsCH/1/O2eDkswMvYcGWZwSosv8?=
 =?iso-8859-1?Q?pbQviCZAc8+HjtmJZmWlgOe8VV6O1eUUxfKQleq9CzvjEMvDDKDknX7Sqo?=
 =?iso-8859-1?Q?l9YQYqbLOftvBLg+ygudhEfGK1uxlkUUpmOEVXgUvAbWfRKNlRcYot85Zj?=
 =?iso-8859-1?Q?d7Y3F+rdxYmC3wu01het779t1FE2zOpGAdeR+A7bnY6hV4lXP8b5yiqA4U?=
 =?iso-8859-1?Q?InLHWY2/zR+EbyGs3VuTiDrpw1CUXYHzTdPlrA9mHNOfHw6CJIyH0bm1nT?=
 =?iso-8859-1?Q?FvI+tsRDTGsLwddlZFVDu4LtEZ7ujxd1l2FCrEFTA3fP1Nl5Z7US+oRV22?=
 =?iso-8859-1?Q?R4mt8X7C1GPbb9d+OfzR0BDC8JXzKe3pMOsTW45ymne5q3cEZpK/iu2ygT?=
 =?iso-8859-1?Q?SFymrVqi+PH01AvsY/4lS8s685EBodqz0PCQSIx+mJ3TFkO5JGF/g2OYCz?=
 =?iso-8859-1?Q?L9r9F6hgohuVNKCROKV1fd+MhkaVgOOUHlcGkmYW9PRBt3GVytxkXTEEtM?=
 =?iso-8859-1?Q?OvDT8Z2OKH28IJlX7V1MFXKx6hEsFigITlw/v59vs1HkTNU5dd7D8eJ7lX?=
 =?iso-8859-1?Q?271fIl8wpjTMqb4mNzKk7EyCfXGryel4zIY9mv2lf+dql3tJUskPLawLWu?=
 =?iso-8859-1?Q?IhwcwkcCeTQeaSeKCwRmRhAicrkfikNzsIfSshGf0Ss6prt7PI0qTDmBvt?=
 =?iso-8859-1?Q?i7xXehtNqBlxdognMqkKlc/SBCJuW0sPt0T9RKjKj3uWe05H7uh4bKpDDE?=
 =?iso-8859-1?Q?jpsBO57i+OmDGmjKR3aKsAsCE6FN942TXCgZE6koskd1DHJX5nhlcpyE/X?=
 =?iso-8859-1?Q?LPX+Aep9TwFQ62TjsaT5as8DxmTB50LeJakEpQnHuEt0voWdFYI7hG7rfd?=
 =?iso-8859-1?Q?+qW8fY4eTg3C78CUrvnZNo+Z7s19bRImp8MdQrfRqRh0HVe/8QFkNP66Py?=
 =?iso-8859-1?Q?FzqgzcSstkpkjMF1ErkNl0I38JTjQ5d8Bm5VHqnJt2Aw46lbGXGicqtfzN?=
 =?iso-8859-1?Q?JXT8g0RhYYL3YwYPeNSWFsTErEeACVWIIPmrkZikxsLQPK5lFAvIYZWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: axiomdatascience.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR07MB9332.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ae661-4680-47ff-2f44-08db9b52e72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 16:40:57.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a40fe4ba-abc7-48fe-8792-b43889936400
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+nrqZFtmnWgNFVKKFH31QJHYlAxJetCXpYwp1bFHiSH/gq51izmEAOadRSP9e0+n/cYJr3OCI/uI5aNoQvWzUE8AhlInhGD7z91VNKTkTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8703
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Just wanted to report that infiniband-diags cannot currently be installed in Fedora CoreOS because the perl dependency is explicitly forbidden.

https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170

This is a bit unfortunate because it also prevents usage of all the non-perl utilities (ibstat, etc) included in infiniband-diags.

Would it make sense to split the perl utilities to a separate package infiniband-diags-perl so that the C and shell utilities in infiniband-diags can be installed without the perl dependency?

Thank you,
Shane St Savage
