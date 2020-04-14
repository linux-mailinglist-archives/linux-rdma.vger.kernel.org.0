Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D489D1A79C3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439461AbgDNLld (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 07:41:33 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:34230 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439458AbgDNLla (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 07:41:30 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Tue, 14 Apr 2020 11:39:41 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 14 Apr 2020 11:40:33 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 14 Apr 2020 11:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giwRWgHy9ep4dAxabGHZrh9RMX44+uHP0NKgbGvYN3pBAfFbSel1Kplxn0Uaxsernuk6uJNFDr3jS7JFuXSUhdDYUZQ+C853SNQRNCjV3l55IiZ6Yo1VezqPj4oOpsHj1o1EVromSbrrjBIO8k/cg/J4F/lOsG69OFlLKQ2KQNZUPndyFIdyRXoN8zRvb5RIRUEqxEFZOZdlxA2/J4157DqiGjed9koy4UQ2NO2Lq/y3Z4/iKac6/4mMB11zK6YlW0EoToJpW5DjOq8PsZHOjzkhuzgSI2ATUTzCRMWjZVQekZ7oBsPFnXQjZ33WQj07ADoRObRVa2KtL5c705414Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WZgp4f1oXNU926ByAju7yrnkr8mQNvSiBpV0E966tc=;
 b=e3ORqp8DQD3GzLIlVa5oYOsVLHh34aQrIj/TS1pIsg3gQeVVXYdCHw7uc4kAmRq7XaXVzhAeg0XV5xXJjRsBaL5aipZlNU3Au3/lOySJjHv69cOQiKPo1HNvqriFwE6LfqlsFjd9q9Trul/HIijTGjNPuwqAVObeGEgku3NALDxU3f02X+57Jm/09lsxlbMMe1D9PTHUnkPVBbhHMxtH1bTDjMqy9jAskr0OC2RBr/FmbbmoGH9KPjtWOc7jEbNNp23Sj5qBNaJec45S52NIt2V+liyawwXIbaOZuWQUnaJNdFl+i0CVR7e+v+dDgOzuBRU8gObJsLzXYI2I1yaSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
Received: from MW2PR18MB2185.namprd18.prod.outlook.com (2603:10b6:907:5::18)
 by MW2PR18MB2313.namprd18.prod.outlook.com (2603:10b6:907:8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 11:40:30 +0000
Received: from MW2PR18MB2185.namprd18.prod.outlook.com
 ([fe80::f06f:cdaa:996a:b710]) by MW2PR18MB2185.namprd18.prod.outlook.com
 ([fe80::f06f:cdaa:996a:b710%6]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 11:40:30 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     <linux-rdma@vger.kernel.org>
Autocrypt: addr=nmoreychaisemartin@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNLk5pY29sYXMgTW9yZXktQ2hhaXNlbWFydGluIDxuaWNvbGFzQG1vcmV5Lm92aD7CwKUE
 EwEIADgWIQRC0lOFwaHAK4sbHG+AG924JZiPZAUCXdJQ5gIbAwULCQgHAgYVCgkICwIEFgID
 AQIeAQIXgAAhCRCAG924JZiPZBYhBELSU4XBocArixscb4Ab3bglmI9kCpcIAL7AH3c23RwX
 GmAx6WxcI/uqN3Xls5pDcDbh9z1Z2H4+3EQSb+ANMd+ILuIZ+91g2xESLrSODvUaR0tE4Ub1
 GFQ2kCyfMPXBt0/qtKVr63mdb1a7f3aqS4nJGaweKJX5NSD5W5Pdg65Mngy8vhXbu+tkmZal
 YjWFElSu9fOa2NgUlqrPn2A/F8zcYXeFGqHR411ii2cr/tHHs0paT7iE/Tr2QDdPCeJZidC9
 HsWoiWSF2WQM/f0HTRrAkcnbQaLUNSQ/UL+prv/thH4vmzdPPkHRARTk4wJi/efI29SyrCwX
 E8dsVBnU+CqnwLHPXe6SbHr2jUvUbzTnOLlAILo9I5XOwE0EWNkRPAEIAL3MDMJGVODPI72y
 JUtBjBtFSFwvVNQlT8WI5BZBOYve4N0FzoyBUGz6GnzZHA9ttdO/hbiuCEFg8p2YVe9E36O8
 YMurV/aGy4JKITVyRMzMVX6wqhZEgQLXa0SnDmdwQUab7WT+slEuT14fG6qf7JGM+vI3wIrq
 0rj5vi1na6sqU/b1cb5PeX+ZtRKip+Oq/J4ppbrHDuS7z0RfZehBY/+mb3ZHFR3pUNT2+lVb
 9Puo9lGXTC1ScOc7bB4+hma9R8Svk6yHcw2+bWbIb6/gRXYeC9o1Pqlrbsim2tSrTpwDp0Ow
 grA+0y5OElCnz/G6aCXlD0D8StCglOsH2tyUibsAEQEAAcLAXwQYAQIACQUCWNkRPAIbDAAK
 CRCAG924JZiPZDA3B/944ikUHrtwqhQm9ybclZy+dqBk67JqwLDHAf1rSj2M5Fyr6ewmjKdL
 8OmNQobJlqDLv4XuwGsXtfHRxcXZ/kGjjZc02JAMTk/9UvC+Cf3rYAnerR2ng7uhAjxSA2Z2
 yhxCE1oEccKg5pssauA2hsNNosF5v3No5mrPwIG4CJnRtUAESmDnSEMRhMeniMKBalp2ECyn
 94KCb3dNz5j57V+q0TcWag4vHKEVrp6+GfRDWJfSQJqwxnCXOx7OotmNMzUqiqfr5QgdcTdB
 pQvIUoPUYOGKxfHKiU4Ho/ZNezJ++K1h0hncIK0js9UPHOZfZeSS8TP1sy1K2gymx72oCyYd
Message-ID: <5139c76d-cda1-f641-f5ca-533acf683869@suse.com>
Date:   Tue, 14 Apr 2020 13:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="vaCcmLU5AAtMiOPkSUL9xhWEVff3et86f"
X-ClientProxiedBy: PR0P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::34) To MW2PR18MB2185.namprd18.prod.outlook.com
 (2603:10b6:907:5::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a01:cb15:235:9700:4a4d:7eff:feda:7c27] (2a01:cb15:235:9700:4a4d:7eff:feda:7c27) by PR0P264CA0094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 11:40:29 +0000
X-Originating-IP: [2a01:cb15:235:9700:4a4d:7eff:feda:7c27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a9c8c5-bff4-41bf-44a9-08d7e068a282
X-MS-TrafficTypeDiagnostic: MW2PR18MB2313:
X-Microsoft-Antispam-PRVS: <MW2PR18MB2313EB7C55CB985EFD1F478CBFDA0@MW2PR18MB2313.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2185.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(316002)(21480400003)(5660300002)(86362001)(66476007)(8676002)(2616005)(6486002)(31696002)(81156014)(30864003)(478600001)(31686004)(66946007)(66556008)(8936002)(52116002)(6666004)(966005)(235185007)(6916009)(16526019)(36756003)(2906002)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps5bXyUblShAJEb1LK1ALVB0JAhuTPHQZxkjihomL4LdghogYFK4avS+rf6WN4YXr1/HfDmRWqQkIocJG2tDuAvsegRqBYlYRisebStwPR1zU7vHd02loarzV5s2G3/Rg6ROEZ+lmeYJa3HwGsJard6EOQ1Xjf4SIMOi2VWotUz1ltuKuiAcz0Y2/kny+H4RIts1+6/OK29zD0hLFf50s+olDTIoOuoS00dUsVqCbv7Bvah9/sUh9Bem1CFE4TJ1XhY3q0l68z/id9S5XIDAn54UcPvk8UtXXC8tNqUkv2WQt5FP1dPdxsJoNE4tc6gej49UTVnzb/lLt8YmIZMMz7v4RhPTk5EZhDkhNe5ckkJF7jP6SWkRowwq9k7LsJqQigO3rMN1dowwdxnTKy53eQAaA+xukfY667NtzdGnRGakO4k/QVLjrMDtD9G6sskcC/lNZjFgsFU/lrLBQKPasT43TcxfKwzdZso+eArCohQZsaVpOe2Ar49Crw0bWAyh63soYpTccrHFRAGyqSiQ0A==
X-MS-Exchange-AntiSpam-MessageData: +B3FEiR5ti4pPsFOC4wyt5T7BPuYLHenjvfWSXr7o8bxSYgAN8Q6QBEyuAjYbb683nxYLvOsOkuyJ8sE3GMstgbg7vFK2X1v4od6eDzUc71DcAyjbxCwdurwdyF33dItHIYspp3B2SY2dO03QJbzT8mfdgv5e57rBJsYDEkw8lMnswvhgPRfEJCzN1Fj/PItz4aP/KR2oTUIdjuRaXMyGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a9c8c5-bff4-41bf-44a9-08d7e068a282
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 11:40:30.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9hEHS65VKNsZjndUwMgS1FZ25kz5Th17isNw8G9XNvKIGyJVvXNk9L+CI5jLykRckNfWdzpVPOat1qUwKPcXk8e/KwcCfB+RI5hC/pBfwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR18MB2313
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--vaCcmLU5AAtMiOPkSUL9xhWEVff3et86f
Content-Type: multipart/mixed; boundary="e9qcEDGtE4bL6AaMeJ58YxvJ0iMrFyjR3"

--e9qcEDGtE4bL6AaMeJ58YxvJ0iMrFyjR3
Content-Type: text/plain; charset=windows-1252
Content-Language: fr
Content-Transfer-Encoding: quoted-printable

These version were tagged/released:
 * v15.11
 * v16.12
 * v17.8
 * v18.7
 * v19.6
 * v20.6
 * v21.5
 * v22.6
 * v23.4
 * v24.3
 * v25.4
 * v26.2
 * v27.1
 * v28.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:26:38 2020 +0200

rdma-core-15.11:

Updates from version 15.10
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * rcopy: fix UNUSED_VALUE
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc8AcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOqFB/4/D0RdZIXif3OzwHJH
pntViDonyiz3Kfi1MZO0z461sYl/fnFof3EyGcyglu3zWuHiay9t++AAAl1hmWf9
Co3VMifOwCc5xyuQ8E4zIUE2pIFWydE6s+SvidyYCpDiOap2D2rKEw3rjK9t19zC
sOIYnRKRftP0/mbA0kgSCPNSDVtqdXgNuJmUdypnXXsneyaySy0qGKOMCs2CJPCP
Lq20WBCFD3qDKRJigkmt9BDiUEOGUDWXyX0h+KuO3htj0vrTPDZWQm1CGyq+joAH
gZjdDAmNc90iad45wLosRmMPgJT3KVcGRJaSNin8AtERdsn78hDSWMvbNDN77ES6
lt/a
=3DkeH1
-----END PGP SIGNATURE-----

tag v16.12
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:26:47 2020 +0200

rdma-core-16.12:

Updates from version 16.11
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * rcopy: fix UNUSED_VALUE
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc8gcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZArVB/48Nn2h9WlgCNkHDFaa
9PYFQtvw6l0GjP8SMWFYFRBp6Tifj2vb9Xv0+qD+OoxACZ6pv3dJu9I4NXAjhbFA
Vw7vyqqU6XnCHAPnf+QBMNAEzmLraqUVhYyfYcW02waUcib7JY48XwnB9eaQXm8n
ZuldcLL6gDYZdATsejo9nn5O6J9gauVOOsm7yaAVUZkvbMSQ44cdn8sgMRoYSTKn
nol2hNRSVMnrZfSRnzvVvXStwBhvA4oDpA6vUwX2jhD+qbAELjNhffd7ajDFnnbb
fo+/oDByXonQ39sYR40iVcjm5Ei/uZpvrs02V510Wc0UeA0b0s4yu4QdzeP/zqwo
13AM
=3DJvOs
-----END PGP SIGNATURE-----

tag v17.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:26:51 2020 +0200

rdma-core-17.8:

Updates from version 17.7
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * rcopy: fix UNUSED_VALUE
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc80cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGsSB/9qQM7kgd7udF6P5bzu
zivCAoSy8SNxd6CUYzdSYYkxIW8azCqYQki3iMKWlKP7+KXSp3AwaNdF7rWy8nr3
WPFJs6LMsz15/QFY0avnowWTOFbDMumMwgXsowlMtnjYLJOMiFcE728WMXubgH3m
IqHCDfMy1RMwvM1lnWEPOc2NgKeizXZ/Y4Sfs/5QaMyseRsz7PpIJ7TjGQ7+KqCE
ZF4Fe/lZTOBOA8W2WOTHSekkWgzbsrvp0nn+AebPPSfIaijwkrBWT0vNV/pu5/DZ
OTOJDqrS1xUPw8/U/xczVhXCO6IWueT5vsMaxTinELOkkEpveS1cAbuQgqgml/rw
b7QF
=3DrReV
-----END PGP SIGNATURE-----

tag v18.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:26:59 2020 +0200

rdma-core-18.7:

Updates from version 18.6
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc9QcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOrTB/4n9xy6iQaaKiyzozZI
9+Y324PfrYLS7EONteOAtj8/tY6tD/hmctPjn9hVEn6Kl3OIKw6sTuOOqZZx2a8S
KwoA9CK13W1b2OmPts3p+VNqu+H20FcYZfFXxtGw0GSs2jj2Bw9Le8TN6pJgikbM
tk+1RAdGDiFUOWtYsD9OTini5D2X4LU5VxMADNoOnI8urs0gZFNnDAZyZXTizZkP
1c6QqpI1y+gil5si63Uow+Ol976k3Kug9AVeqaMlJdKeXPKl8vXB/hQxwyQp5rPy
dBOnF5y94/sWAiVjKaJcWepEPJtSxhuGtUHFlfmgykeDH4+s2A9FzVotpjzIuzcH
ElPU
=3Dw+2I
-----END PGP SIGNATURE-----

tag v19.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:03 2020 +0200

rdma-core-19.6:

Updates from version 19.5
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc9kcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBm3B/9IEw1PmFEXGRDNdrXj
yGyZLM7EOijqOciAqfn/rfddmKG5EEYMlPh+9R1fwIooitXUQX3/lTtC6vZOQ5Or
hluLsbbX3qEFGeXEHYff5J4J1rscATgDF+eZJpNKosS/vJShqwtYSvNZexMymYmu
Uy3OtqvEjY9zx27JO+49jqEh1zqbou5H8Me9uhbjLQ+u162Jcl1PRTSa+XjJiSL8
Ee4ELdAr8wF+XUq7/sZSXc0uOf4aZAz8hFQ3gN9x9O1Fal1DVLSe5YvpVIZtUIHi
YbR1ro1qmHZpmWyK8Kgf5irDqCTU9ocO2wec5+GTTZD/75RKkOdzgYfu4YKx7eLJ
xdRj
=3DQVdq
-----END PGP SIGNATURE-----

tag v20.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:08 2020 +0200

rdma-core-20.6:

Updates from version 20.5
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * libhns: Not process return value of flushing cqe
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for assigning sl
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc94cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZC2vCADDJAhevrnOsfxs8E2/
yr5wKf3044NAUDHDH216AxQX9fu/SyA9q3ttkOWgcvJTpmPxTf+AFR7gOfRS/kEe
QW5SwSrH3f8p3K0HZifbeaoq6VG4xuPNuF1+rUi+KK6WqZnZdicF0x3kHs7oeH3n
oFhBH4KgAgeyvl+6wBt4OsThvz2eZ9jSJ24kl7Xrjk9Av7ifP+o6oKuLeUdEWgWS
JhpAsJ1lQ6t8plqU42L2SkKmy6xm8Z9NAvgyABjFu4IC6//L3AUPGJ0xgVN/NaCQ
JSJyQtIdXMByxLV63aMi52uVJT5c8nTEHJo/xL3rMAWaSus5xW/YwmowXzTzafNm
sDzC
=3DOgei
-----END PGP SIGNATURE-----

tag v21.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:20 2020 +0200

rdma-core-21.5:

Updates from version 21.4
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * libhns: Not process return value of flushing cqe
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for assigning sl
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc+ocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFwdCACaWFJwUNPhB/1v49Cu
Kk9E3l61LWGdzJdotoDEz6fHCsDsp45jxivr4nhESTmeJU6R64vB9GKSjpZ1p/Qm
FXylVokB1hP4dfTvbuywst5HcruJANkD/tl3cqFb9s04/seh8X1WB+2vE2BIlM2p
NMmnjbILkP20FaMo9sEKnz/ZrPSAxu1nl17Q8mt5ZaG6ucx3Ziro549gv1VQsoA9
UHYXlN+CuERromyvvOWtLusnZ6qdhRsPCBOow5Ij3r9dw/FPNJd2oz9qwTH1sMKy
gtsanISfJcM2+qrciv2KD35OzqDsXhmfWQY56HkKT0zSMnAR41tsemuEBEHWZKKt
ArS5
=3DCrcs
-----END PGP SIGNATURE-----

tag v22.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:28 2020 +0200

rdma-core-22.6:

Updates from version 22.5
 * Backport fixes:
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * libhns: Not process return value of flushing cqe
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for assigning sl
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc/IcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBGSB/92jyxbCB1yzy/F97zW
TVTv5MQiZLTHnPAulnkJCMTDL9i1WA0hrtTqjYsb77esrprFkX1Yg6Mn/7vfsMDK
oYD8ooXSqQu3prM/ahEehCHkxM8HvdeTqYu8BG7t/PuNbZY+yoSYmJDEL5Jlbg69
kq7u6E54In1jY90ILM9gwE6aIxE1CsnxvoIUbK7b5gBKir/uX9KF9u4R0que2JIn
rAwJlKVhZJKhPSMIgoGejrca0VFlpkfKxYv4K5LcKif7TV7kYgO4HuAOJMBV2r2x
TtxjyYQeIUdWNmc/l/IDObGTBWGGwpbntG+xYZ3MdPBvDJtC10eTIIOYBkjKO4re
HprH
=3DjCQS
-----END PGP SIGNATURE-----

tag v23.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:36 2020 +0200

rdma-core-23.4:

Updates from version 23.3
 * Backport fixes:
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * libhns: Not process return value of flushing cqe
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * tests: Fix checking page_size_cap
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Return correct value of cqe num when flushing cqe failed
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for cleaning cq
   * libhns: Bugfix for assigning sl
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6Vc/ocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZH85B/4+2WySa+tZWQyBPP5K
gDXxjHWJNbpRc7d+66nYzmR9DjjbCc26o0776GwIkhmzJMoiHJUOe7Ht3rCs4ofa
RIPYSQ13KVbQz0DIy8TAoJmqjG33LJgPtqvYqaPv8+CZmUYGwvdg7bgV/AygK3K/
2EG/qEA0Y3q5a/Ij9a1Wi6ig0BKYh7+3PMGFW2vKeqOiPbtZhNQ4qx+Zf2aUR9VM
mWrHLVnlM7QIsa33v2YK44WgKU3KVquJfftJXwLco90l3Ai0zBkp5WAzNvEFYDOX
yctctt0I7UKV/ayIpY/IGtGnVC6CrL1IdWn3B7zEwl/KhPpeMwosPzex6G2zHmNo
Yh4M
=3DB+Eu
-----END PGP SIGNATURE-----

tag v24.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:27:43 2020 +0200

=3D1;5002;0crdma-core-24.3:

Updates from version 24.2
 * Backport fixes:
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * kernel-boot: don't return 0 when failed to allocate name
   * libhns: Not process return value of flushing cqe
   * pyverbs: Fix port_state_to_str function
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * kernel-boot: Use node GUID instead of system image GUID
   * tests: Fix checking page_size_cap
   * ibacm: Fix bug in acm_get_ep()
   * libhns: Fix for the error code when polling cq
   * pyverbs: Return correct port number in QPAttr's AH property
   * libhns: Return correct value of cqe num when flushing cqe failed
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for cleaning cq
   * libhns: Bugfix for assigning sl
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VdAEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLEzB/kBwJcherDowX9jRwCO
8dMdFV4mBbapH7G8n9r6HmIJNHqFXK51H09lJRk4EpPYDj7AtEF0T/L2EBxhzUS+
q8WpcOlJAhulnp8Enwyj3JXpfGmqDPQC3acg7IKpDv6w+0pD2DobkL3SX1VAPbkn
iFLZXsg2iApSsag4al+cdzUBobZ9hhRY0ffgIoBieFmFRH3BDP1pM6OrPRbNvoM4
m+qV88rICfYfxmWuNtbCPgCZX3WZU5KeAxaY+10FRqc4lFAMAfETYsTwfWcNdfO/
hQklYMsoSVYnynttvG0eFrIPI6IKG1Qn/dd30h7Hu3ieiqGiFFq1d6YGdbxevujw
Adev
=3Dnb4J
-----END PGP SIGNATURE-----

tag v25.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:28:00 2020 +0200

rdma-core-25.4:

Updates from version 25.3
 * Backport fixes:
   * ibtracert.c: fix RESOURCE_LEAK issues
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * qedr: Fix USE_AFTER_FREE issues
   * kernel-boot: correct precision specifier
   * infiniband-diags: Fix memory leak in function rereg_and_test_port
   * infiniband-diags: Fix memory leaks in ibroute.c
   * infiniband-diags: Fix memory leak in read_ibdiag_config
   * infiniband-diags: Fix two Coverity 'invalidScanfFormatWidth' issues
   * ibdiags: Dump only supported extended port counters
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * kernel-boot: don't return 0 when failed to allocate name
   * libhns: Not process return value of flushing cqe
   * infiniband-diags: Fix a CONSTANT_EXPRESSION_RESULT issue
   * pyverbs: Fix port_state_to_str function
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * kernel-boot: Use node GUID instead of system image GUID
   * tests: Fix checking page_size_cap
   * ibacm: Do not open non InfiniBand device
   * ibacm: Fix bug in acm_get_ep()
   * ibacm: Fix a memory leak in an acm_open_dev() error path
   * libhns: Fix for the error code when polling cq
   * pyverbs: Return correct port number in QPAttr's AH property
   * libhns: Return correct value of cqe num when flushing cqe failed
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for cleaning cq
   * libhns: Bugfix for assigning sl
   * libhns: Optimize bind_mw for fixing null pointer access
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VdBIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZG9aB/9cmo5vUhZFAWf4Ql+l
LuoXIfMAt5zgLY5CZOd/E1q2ZDtDyJde+DnuZHc/x59Y7ScKGIdmd6VVO0mN51iZ
smsI7Vj3ZFh3OOO1JyoSLO9ycAmImrktE+MQawfb8M5Y3EH/zszxiiGwRqg/ahfD
Hi/NI9HVFAV2T4IrMNQwPZBsvNxcTYBaWAADqolUZfz2ZHnTzNIDl5llIE1NbE9D
DJgWw+7pcXpwGVWRxy0wbLNkGGIzScSdfJTVVpRRlvD/uCs+f+Cl0EZKJSvxrpA1
z1KQeEQCtYvi3NoGPTNMJj77oRnmmUGuZR0ZoJUm/q9+wrHZyT6gr7Q3xcFxJAeq
Q4cF
=3DqRFs
-----END PGP SIGNATURE-----

tag v26.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:28:11 2020 +0200

rdma-core-26.2:

Updates from version 26.1
 * Backport fixes:
   * ibtracert.c: fix RESOURCE_LEAK issues
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * qedr: Fix USE_AFTER_FREE issues
   * kernel-boot: correct precision specifier
   * infiniband-diags: Fix memory leak in function rereg_and_test_port
   * infiniband-diags: Fix memory leaks in ibroute.c
   * infiniband-diags: Fix memory leak in read_ibdiag_config
   * infiniband-diags: Fix two Coverity 'invalidScanfFormatWidth' issues
   * ibdiags: Dump only supported extended port counters
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * kernel-boot: don't return 0 when failed to allocate name
   * libhns: Not process return value of flushing cqe
   * ibdiag: Compare CA device names by using the maximum length between =
them
   * efa: Use the correct barrier between BAR writes on post send flow
   * infiniband-diags: Fix a CONSTANT_EXPRESSION_RESULT issue
   * pyverbs: Fix port_state_to_str function
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * kernel-boot: Use node GUID instead of system image GUID
   * tests: Fix checking page_size_cap
   * ibacm: Do not open non InfiniBand device
   * ibacm: Fix bug in acm_get_ep()
   * ibacm: Fix a memory leak in an acm_open_dev() error path
   * libhns: Fix for the error code when polling cq
   * pyverbs: Return correct port number in QPAttr's AH property
   * libhns: Return correct value of cqe num when flushing cqe failed
   * libhns: Avoid null pointer operation
   * libhns: Bugfix for updating qp params
   * libhns: Bugfix for cleaning cq
   * libhns: Bugfix for assigning sl
   * libhns: Optimize bind_mw for fixing null pointer access
   * libhns: Fix calculation errors with ilog32()
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VdBwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBARB/0YWfNozOKZtNFNwWvr
9Mh1siTSHbvn5jVVHuQwJp8RNwRdjRXgQ5wtC5k6PUl9yhXe4aweBfI0OIe9uWI+
8AOy0/NcHzpFHfEWDODm2ZRGsIiZH8p1AW5gQhn2r6dOgRo81YRnkqBYz5ZysQNB
hD6X2kaVLdTabHLLv5eZP+gm/woSnEvl/A3W7myZ9E+Ify3b4PdePXxTa/a0f1om
LsmtlWB65rlJUfPR1J2nCU/FGEff9PZz9kwLD3+vhpLY8UXOLVXGweE3kk+KQMS3
Vx3dPko36Auh+ZwOU/q6ONCvkhX0Na/gKH1QXpSmDuzdFpwYey6rUoiJfYXihoMX
RJL3
=3DiIVp
-----END PGP SIGNATURE-----

tag v27.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:28:22 2020 +0200

rdma-core-27.1:

Updates from version 27.0
 * Backport fixes:
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * mlx5: Fix postsend actions write length
   * qedr: Fix USE_AFTER_FREE issues
   * kernel-boot: correct precision specifier
   * infiniband-diags: Fix memory leak in function rereg_and_test_port
   * infiniband-diags: Fix memory leaks in ibroute.c
   * infiniband-diags: Fix memory leak in read_ibdiag_config
   * infiniband-diags: Fix two Coverity 'invalidScanfFormatWidth' issues
   * ibdiags: Dump only supported extended port counters
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * kernel-boot: don't return 0 when failed to allocate name
   * libhns: Not process return value of flushing cqe
   * ibdiag: Compare CA device names by using the maximum length between =
them
   * efa: Use the correct barrier between BAR writes on post send flow
   * infiniband-diags: Fix a CONSTANT_EXPRESSION_RESULT issue
   * pyverbs: Fix port_state_to_str function
   * pyverbs: Remove errno param when raising PyverbsRDMAErrno
   * libqedr: Fix user context allocation forward compatibility
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * tests: Use post_recv in the right place
   * kernel-boot: Use node GUID instead of system image GUID
   * tests: Fix checking page_size_cap
   * ibacm: Do not open non InfiniBand device
   * ibacm: Fix bug in acm_get_ep()
   * tests: Avoid code duplication
   * ibacm: Fix a memory leak in an acm_open_dev() error path
   * tests: Fix query GIDs
   * libhns: Fix for the error code when polling cq
   * pyverbs: Fix PyverbsRDMAErrno() takes exactly one argument (2 given)=

   * tests: Fix exception when no IB device found
   * vmw_pvrdma: Use QP handle when attempting to flush CQEs
   * tests: Fix exception when running the tests from the tests directory=

   * Documentation: Update testing doc
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VdCccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKyUB/9XGgQcZznG+cuIEIxE
szQMj18yOxWF1pEAWCG3jTY58rXhCDIyuscbJwgq03MCq3Q3+41hAVlW7z5stv3c
dKqvfmZ9nWk/AZqyMW3t6ZGTAQpwVaGmE/6ScoYqRmP5rfvvH+6TXglOv19lfE4J
chBgBuuqtlPqF24S+7fDzJFzufVhkD5tsjO+S2ERhTd0O00gXJ1T5DdEvEfefQsE
EZnqAfECu2es6x1mI55ImuuOe3yp1IxfnJai01gaf45o6uES52P8VzMen6j+FaHr
FTYFI6MN666hoIyn/iw9QNM2mtLT+nrcWcNJb1AzZYb6saZkwM8ceUr6WdvuFVts
FSDT
=3Di48Z
-----END PGP SIGNATURE-----

tag v28.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue Apr 14 10:28:29 2020 +0200

rdma-core-28.1:

Updates from version 28.0
 * Backport fixes:
   * libibverbs: Fix query_device_ex dummy function not to return EOPNOTS=
UPP
   * ibacm: Fix id_string pointers after end-point address re-allocation
   * pyverbs/mlx5: Fix Mlx5Context to open DevX context
   * ibtracert.c: fix RESOURCE_LEAK issues
   * iwarp_pm_helper.c: fix RESOURCE_LEAK issue
   * rstream.c: fix RESOURCE_LEAK issues
   * xsrq_pingpong.c: Fix RESOURCE_LEAK issue
   * ibacm: fix a RESOURCE_LEAK issue for acmp.c
   * mlx5: Fix postsend actions write length
   * ibdiags: Dump only supported extended port counters
   * srp_daemon: check return value of function 'umad_init'
   * Fix shiftTooManyBitsSigned issues
   * rcopy: fix UNUSED_VALUE
   * kernel-boot: don't return 0 when failed to allocate name
   * libhns: Not process return value of flushing cqe
   * ibdiag: Compare CA device names by using the maximum length between =
them
   * efa: Use the correct barrier between BAR writes on post send flow
   * infiniband-diags: Fix a CONSTANT_EXPRESSION_RESULT issue
   * Fix compilation on i386 with gcc
   * pyverbs: Fix port_state_to_str function
   * pyverbs: Remove errno param when raising PyverbsRDMAErrno
   * tests: Fix errno check upon mlx5 VAR creation
   * libqedr: Fix user context allocation forward compatibility
   * libhns: Update ibvqp->state in hns_roce_u_v2_modify_qp()
   * vmw_pvrdma: Avoid double unlock on qp->sq.lock
   * tests: Use post_recv in the right place
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VdC8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKOnB/93bdd03XrdWHppP/ah
BACR1hMwBVqBP6LPZslqnK/3f36uWbvjM3aFgIUzk0K9jRaVhQ3YewB4bL7npgJQ
73GOmr4AutRUTrpm5Qaxg31w7Jusl2uqBnZB4WubGgf4NPAGwvqyNhD0p4zvGEa9
vi16Lbi20ioN+/quosuw3y9iSwW2xhZE94UCbNj3yAWXJD0XK+JiUpVa4ln5xLNg
FUZeIah5ZRTd/zKJg3UpMg0YLfwgo8yERWANjXMIadVl4YPWJIZyDtCvQ+cyeC1w
bWa8U75sAD8w+8kAHMnOgXad7pwBsNItnogU7coKxriCLwf8rvXKerNupt0coJhN
mm81
=3DWfTD
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases


--e9qcEDGtE4bL6AaMeJ58YxvJ0iMrFyjR3--

--vaCcmLU5AAtMiOPkSUL9xhWEVff3et86f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl6VoSIACgkQgBvduCWY
j2QaAwgAvqGdWQ+f2rJk2AQtWsaW9AR2mFDT1XLbQUz2+y5ssTrDetNmdr4K9M7J
z9zgfounbvTlEaiqj8f1idtrZpfWo+BtxZQ2sTL+vnmcaivi2/2mSEWuLL17zKKC
yvzgKUp+QnD8aZQW22xSCL25324FJzH+2HO4NWO+oIkqxEFqWwTnVuDu5IPPBXdQ
TbzJhd2J3ABDGvkZVjLHusXppFLDbM+3vwyoLMi6umGOfMymmDoybXBHK6cYDjtK
ate8PQcWm2cIejt+eiUZJyabI5BRGcvCHzDFDtHO8eiPiSSUkrZDhFtqr8j1ZD9U
9qd9gjd0rljpYcxC4cZbSMcbTLvrRA==
=hNNk
-----END PGP SIGNATURE-----

--vaCcmLU5AAtMiOPkSUL9xhWEVff3et86f--
