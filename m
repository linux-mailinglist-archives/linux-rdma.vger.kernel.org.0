Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372221E0E96
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 14:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbgEYMlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 08:41:36 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:60270
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390488AbgEYMlf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 08:41:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEnJXJm5cLaDswCK7ySYMlG6CbsqhYBdpo4Ub0CocB/viYoQyddQ9z+jiaCuLpC9pbbVI1zOpblAqR00J4EW4y4dH/AjUQVd+FzdorJB/RrOJu+Jl3uTzo3LBBsj10fNFtjQlY9i0t9BzaMfjHdnyAfxStnfk3MfHU5Kz1b3GQPokohv5gHWXKarvQK7gnTC8jPzBGuq1Cj8ySw6Cral5MLXgelYpEPEJXlT4G4AEb5sWjNar+iMzpRqJSiG9lFEc+j4q4nTEf9H1jG6APIJoM+erPk+jZu/xzFPmJcpQx5Fwg+i36tAia8YmuydaNlJgvixSblm7RQbZWZUCnMcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qG2ukZwy+YQyL8oHFk3sbYpqxPurCarljFKU/Y4rjQ=;
 b=Ay7azBhSCbbvkCfMFkqQgoNMlkNxc0EBhLFqOMs9WZX+ICw6fscGVlc01DpfAffhe2wJWGYYzggupQhA820CU5C+VnKPgocPl0DnYQTme1qHGTssSeM2qmnm+Pj+52hfOpJG8HHaGhc4zxF3zH9nhYGpH39O63ViANEJubAd+RnxQmAnagwLgUll7wDmMFagNGUZSSaXn3sdOTisH2VlxJrSqEY2+nDMJmMmqAo7Y/OmjVJBTrAJep/00v4hPBsx5+F1hbGJnzqGFK8q9TnAcyMkZRCduWwALcC2JH1WjNbTCZ6LS8kPk2iONT5uGUFRp/FXWM+VBC8Yt0vz+VbaAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qG2ukZwy+YQyL8oHFk3sbYpqxPurCarljFKU/Y4rjQ=;
 b=DCBVxqF1YQ1N53E85W+j2Mzu4shFscXnOpPo91cMO2vJE7Z9XMNOe7qVMevUaidFX7iEGfKXpHNbBcwIzUuG4gx54uKhwCtWgydL+lw1otXHB56t5seiui1xuoZsnfEdddj+PiHbQycMmsj7BpD7pfLcJK1ZrgWw+NGwE/bt+aM=
Received: from DBAPR05MB7093.eurprd05.prod.outlook.com (2603:10a6:10:18d::10)
 by DBAPR05MB6920.eurprd05.prod.outlook.com (2603:10a6:10:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 12:41:32 +0000
Received: from DBAPR05MB7093.eurprd05.prod.outlook.com
 ([fe80::319e:1e82:f23:270b]) by DBAPR05MB7093.eurprd05.prod.outlook.com
 ([fe80::319e:1e82:f23:270b%8]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 12:41:31 +0000
From:   Vladimir Koushnir <vladimirk@mellanox.com>
To:     David Zarzycki <dave@znu.io>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: opensm and virt_enabled?
Thread-Topic: opensm and virt_enabled?
Thread-Index: AQHWMpBJPHTTcI7LbEipEi1RIaPPmai4vgsw
Date:   Mon, 25 May 2020 12:41:31 +0000
Message-ID: <DBAPR05MB7093D9F64237F31DB615DA20CEB30@DBAPR05MB7093.eurprd05.prod.outlook.com>
References: <38bdd48f-d1ca-4bce-9c9c-30925b158664@www.fastmail.com>
In-Reply-To: <38bdd48f-d1ca-4bce-9c9c-30925b158664@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: znu.io; dkim=none (message not signed)
 header.d=none;znu.io; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [89.138.221.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2124dd0-92b2-4570-edcd-08d800a8f3bb
x-ms-traffictypediagnostic: DBAPR05MB6920:
x-microsoft-antispam-prvs: <DBAPR05MB692082816085FC676752B0F3CEB30@DBAPR05MB6920.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gq/ZtOJGvOTJ2eTM08mxIWV4kw7e9gkvqggFR1yfeZTDLoFl++A8/2zOmrtWdhAgH4rxyqNY+mXVbh3ulFfIlyg8vog+oSetr3Mr0TnTTFZc6tRs8qwKzGjKIBfrUkziVQLODbkM1sUkeLCDQKZ42A8bWrcPuR/Yvt6rGKjSpmtrBNQyYnduisKq2Tbpj+h41r9grmgG+QHIuH1JMeAB9tbFGMoU4VJ42AL9qOqiZL5B+axny9V4usNUmBk2qj6Zo0HPxqsk2Ld3cMWtIaPGjEc3jRGDGSRYhP9yiIbnDEopWGuDEjqs3wfAPN5Y1EeWb5jgyCusdE8iYHlCGqvWRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7093.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(5660300002)(8676002)(26005)(76116006)(53546011)(6506007)(64756008)(66476007)(66446008)(33656002)(66556008)(52536014)(66946007)(8936002)(7116003)(110136005)(86362001)(7696005)(478600001)(9686003)(55016002)(186003)(316002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MpAGPA5Rbxaac4AVEESx8gVYwSTfX98CGDR956n/9pQ4hF2NwQfvKpsMqObGtYBaYMlrnz1X1lRRjcoXiEsZGVb2ZWDfmyZRFR68d0NZYhsHnj3wb/v1PthuHng1j3W3qxdREQ/hu6x65u0L4jHReFxadC67u3f7K7USqWPJIkQnzdIPQfoctBjc4ecQ2EG5StrCHtZTJtz2gjP4xVFYZH+bpvnSVSIVyR/9/txAF94yIbVRx5akMoIojiXQeISKLYjrQL3nsg4iOqjR0USqXrvQY8/t6LQmDCMKP7FL6bp96fbsIT+2u0CiCgrXwDq8w8vZ+gAANkxfh3SD1GY52FSzXb3yweVq+Mw4x3ctB2BIuaB6DIwB3vgWFnWhLmR+iHMz2cl8QnC/7g1BaLcOy/CCvTUZhjrOnGF5T0ZmyfYX0oKLBtgq50CawrMNLx/TIg5/8iJfamx1g9DZ3b5KIdOpEmRAIEUIDy0gyaYFntGJdRdb6uyB/ez1+4YInayW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2124dd0-92b2-4570-edcd-08d800a8f3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 12:41:31.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNbLHMf0LSN3Q2Ked243VpnXfd9IRyNfVdn1f1G8WFqMSiVcoGOBDcjgSBH0ixs3Rrme79sXuw60JycEq2pBzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB6920
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

"virt_enabled 2" is supported by MLNX subnet manager that is available via =
UFM/MLNX OFED/MLNX Infiniband switch OS (MLNX OS).

Regards,
Vladimir
-----Original Message-----
From: linux-rdma-owner@vger.kernel.org <linux-rdma-owner@vger.kernel.org> O=
n Behalf Of David Zarzycki
Sent: Monday, May 25, 2020 3:30 PM
To: linux-rdma@vger.kernel.org
Subject: opensm and virt_enabled?

Hello,

I'm trying to track how to enable "virt_enabled 2" in opensm. Various Mella=
nox docs refer to this change in opensm behavior in order to support their =
socket direct cards. That being said, when I search the opensm source and s=
ource history, I cannot find any reference this flag ever existing. What am=
 I missing?

For reference, I've connected two ConnectX-6 cards point to point. One of t=
he cards is "socket direct" but the aux card stays "down" despite the link =
being up (see below).

Thanks for any help,
Dave


CA 'ibp2s0f0'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609810
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Active
                Physical state: LinkUp
                Rate: 100
                Base lid: 2
                LMC: 0
                SM lid: 1
                Capability mask: 0x2659e848
                Port GUID: 0x0c42a10300609810
                Link layer: InfiniBand
CA 'ibp3s0f0'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609814
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: LinkUp
                Rate: 100
                Base lid: 65535
                LMC: 0
                SM lid: 1
                Capability mask: 0x2649e848
                Port GUID: 0x0c42a10300609814
                Link layer: InfiniBand
CA 'ibp2s0f1'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609811
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: Disabled
                Rate: 10
                Base lid: 65535
                LMC: 0
                SM lid: 0
                Capability mask: 0x2659e848
                Port GUID: 0x0c42a10300609811
                Link layer: InfiniBand
CA 'ibp3s0f1'
        CA type: MT4123
        Number of ports: 1
        Firmware version: 20.27.2008
        Hardware version: 0
        Node GUID: 0x0c42a10300609815
        System image GUID: 0x0c42a10300609810
        Port 1:
                State: Down
                Physical state: Disabled
                Rate: 10
                Base lid: 65535
                LMC: 0
                SM lid: 0
                Capability mask: 0x2649e848
                Port GUID: 0x0c42a10300609815
                Link layer: InfiniBand
