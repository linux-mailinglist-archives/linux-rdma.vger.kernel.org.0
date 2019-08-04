Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B185809C1
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Aug 2019 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfHDHBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Aug 2019 03:01:32 -0400
Received: from mail-eopbgr810134.outbound.protection.outlook.com ([40.107.81.134]:60333
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfHDHBc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Aug 2019 03:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZWRfoEVONCtyqQKgf4PmISPzyHP7VeWU+/xAe6MTZfvJ/TSBgX9JzwYLr5/VkVsoKqqBFDDgY4mlFhx6aAqkfjZRWoH36JnP34UhdenW27ZdnqkO6Ix4UAJzg1hgECe5pOr6J0HQSJSgEGLhlbz7jwUNAhMp7lt5fNNllM4Dm81qgMqo5KZcThiWNh6p8Ga3k7ooFbrObyANXzOgmPzBjQpfHPksXIsncMqqiV+iGHTfttvVjm+nKJLq4kUFgt+9a/vq75SQxxo/mlzCA+CeFEAleCwplo1WDCwGDWttdmGN8qfFm95cscfoNKzl94Z/9/MO0CqS9BgrnbNjM8hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh8YSKglYjz7Baw1KRzrMH9/fe9PFWQujpwaPmRc3t8=;
 b=gnos3/4tgEI73EYOQ40auPm3mImZ0aQldWnWleOoiwtFyGD1u0wGPB/abUbzV0q2T1cxsrajdCkYGAuj1Vl3umFy04wiQEyOZTj9pFZ1eJpdXsGOjjI1K3RadetDDM87vuy39fjX87+7x06WSeSE9Vjb8SqwNNOu24anhhOZTe9g+VgbCBQiZTmS/k7Yd7VUvciQssgSc5KlHfGwZKB6jaW9eWkCGD6ON5EcMS7iLeAhqhjItr7kl966lqfzLUf76UN7vKt8j6wlhKbJ4pnlygjL7lWsf2oLuVTcXIPApVbswgwx88qdPtDYq/v6+6R7FJ71ptCzgvUc6jeVk049kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh8YSKglYjz7Baw1KRzrMH9/fe9PFWQujpwaPmRc3t8=;
 b=eFwApAVOhfKiNvQc3XtuDVAecSqg5DwwTXoti/WrkoyHYOkCeWAsGUJLkfqcR2Bk8Dde1OQKPS4H+5bEDduwbvbMDJQSJhkCBibGQlUArVycCpqk8I0ilm/FSAyc9m8pogQlCEug5mSRV/lvxfzhYkRKt8tSOC0T76clXDoxyf8=
Received: from MW2PR2101MB0986.namprd21.prod.outlook.com (52.132.146.23) by
 MW2PR2101MB1130.namprd21.prod.outlook.com (52.132.146.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.3; Sun, 4 Aug 2019 07:01:29 +0000
Received: from MW2PR2101MB0986.namprd21.prod.outlook.com
 ([fe80::f514:511b:3d64:c86b]) by MW2PR2101MB0986.namprd21.prod.outlook.com
 ([fe80::f514:511b:3d64:c86b%7]) with mapi id 15.20.2157.001; Sun, 4 Aug 2019
 07:01:29 +0000
From:   Ju-Hyoung Lee <juhlee@microsoft.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ju-Hyoung Lee <juhlee@microsoft.com>
Subject: rdma-core compilation failed in Ubuntu 18.04
Thread-Topic: rdma-core compilation failed in Ubuntu 18.04
Thread-Index: AdVKWzl6JSLC+jPATI+BOK7sDOqh5AABHJ3AAAyqj7A=
Date:   Sun, 4 Aug 2019 07:01:29 +0000
Message-ID: <MW2PR2101MB0986515AF6DD01233D7D7AA4DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
References: <MW2PR2101MB0986F5879CB967B453141E93DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
 <MW2PR2101MB098617BA469695962B163707DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB098617BA469695962B163707DADB0@MW2PR2101MB0986.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juhlee@microsoft.com; 
x-originating-ip: [2601:1c2:4b00:8ff0:79fa:3262:c8e9:8b7c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c04b2a5-1cd0-43db-c91b-08d718a9930e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MW2PR2101MB1130;
x-ms-traffictypediagnostic: MW2PR2101MB1130:|MW2PR2101MB1130:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <MW2PR2101MB113092533D5B5BD7CD7F908CDADB0@MW2PR2101MB1130.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0119DC3B5E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(189003)(199004)(53754006)(2906002)(6306002)(8990500004)(33656002)(5660300002)(5640700003)(316002)(19627235002)(7696005)(2940100002)(81156014)(81166006)(22452003)(6506007)(8676002)(86362001)(476003)(478600001)(446003)(11346002)(14454004)(52536014)(8936002)(10290500003)(6436002)(4326008)(10090500001)(2351001)(46003)(64756008)(107886003)(66446008)(25786009)(66476007)(66556008)(2501003)(486006)(102836004)(55016002)(6116002)(256004)(14444005)(76176011)(53936002)(99286004)(66946007)(74316002)(9686003)(6916009)(186003)(71190400001)(71200400001)(305945005)(68736007)(7736002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1130;H:MW2PR2101MB0986.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jHwIBdMSwEgXyISO8TA5dZOY1xZa8ATn7awKQtfUoaqJjkRi+kUqExN0pJyEcu32uVBAfFWWQFPuCVwMJv3LIM43eKgoW4k0WwNFOLn6K3zgoAMu5Cpe2BkHuPkxnWKFkGhn4M5RTCxhu/yJETQxnuR6xlHokChGqAiDf1XPAsnBTioiEZDHCoITJV+yXj2M71zR9/JMzyiUaHx3hPxZmmhuugy8Prxj4XBqWPfWLX4WqYweFRUT//feUwHcgTUDqNoGxGZlBeRrxWPFH4vO38jOgpv1Kl6kVHHA+uD2fK/36RkgOqpLudG5wP2fB9f/Q62sOcTtWTRVNMXNnOMqo9b+8KZrEXI/bkPP6R2/td5Kv9EnpsJV7BYGiJWxgHavz64bLi7bhhhAxa4760zuBgxnjFtGa8cb5AxHjnwMVuk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c04b2a5-1cd0-43db-c91b-08d718a9930e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2019 07:01:29.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0Ylrx+mwnbIiPq5bp5kzyN/rZkH05H1GqskguNcYS8WCXZRQrGnERbStK4YpyIpkiwITagwudln4Lyt8jVbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1130
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

This is Azure VM with Ubuntu 18.04, the 'bash build.sh' failed with below e=
rror. I post the required information below also.
This is Azure Standard_NC24r VM size. So it has GPU and RDMA enabled. I don=
't know what it means "cc: error: unrecognized command line option '-Wcast-=
function-type'; did you mean '-Wbad-function-cast'?" I did not modify any f=
ile. If you need any, please let me know.

<how to repro>
%git clone <repo of rdma-core>
%cd rdma-core
%bash build. sh

<error>
root@juhlee-137339034-1:~/rdma-core# bash build.sh
-- Could NOT find cython (missing: CYTHON_EXECUTABLE CYTHON_VERSION_STRING)
-- Could NOT find pandoc (missing: PANDOC_EXECUTABLE PANDOC_VERSION_STRING)
-- Could NOT find rst2man (missing: RST2MAN_EXECUTABLE RST2MAN_VERSION_STRI=
NG)
CMake Error at /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.=
cmake:137 (message):
=A0 Could NOT find PkgConfig (missing: PKG_CONFIG_EXECUTABLE)
Call Stack (most recent call first):
=A0 /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.cmake:378 (=
_FPHSA_FAILURE_MESSAGE)
=A0 /usr/share/cmake-3.10/Modules/FindPkgConfig.cmake:36 (find_package_hand=
le_standard_args)
=A0 CMakeLists.txt:436 (FIND_PACKAGE)


-- Configuring incomplete, errors occurred!
See also "/root/rdma-core/build/CMakeFiles/CMakeOutput.log".
See also "/root/rdma-core/build/CMakeFiles/CMakeError.log".
root@juhlee-137339034-1:~/rdma-core#

<System info>
root@juhlee-137339034-1:~/rdma-core# uname -r
4.18.0-1024-azure
root@juhlee-137339034-1:~/rdma-core# more /etc/os-release
NAME=3D"Ubuntu"
VERSION=3D"18.04.2 LTS (Bionic Beaver)"
ID=3Dubuntu
ID_LIKE=3Ddebian
PRETTY_NAME=3D"Ubuntu 18.04.2 LTS"
VERSION_ID=3D"18.04"
HOME_URL=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fwww.ubuntu.com%2F&data=3D02%7C01%7Cjuhlee%40microsoft.com%7C3275e088e3=
d6452057dd08d71876d722%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6370047=
71040425693&sdata=3Dz12ZYrq8XWY3J6SZnGiS11FKUyqgXYGVGchYQfH%2BrnY%3D&reserv=
ed=3D0"
SUPPORT_URL=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fhelp.ubuntu.com%2F&data=3D02%7C01%7Cjuhlee%40microsoft.com%7C3275e0=
88e3d6452057dd08d71876d722%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637=
004771040425693&sdata=3DdjbqW%2BCC5dKJJ0OAjFUjN8KJS6vG%2FV1VIQBjgLADuWY%3D&=
reserved=3D0"
BUG_REPORT_URL=3D"https://nam06.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Fbugs.launchpad.net%2Fubuntu%2F&data=3D02%7C01%7Cjuhlee%40microso=
ft.com%7C3275e088e3d6452057dd08d71876d722%7C72f988bf86f141af91ab2d7cd011db4=
7%7C1%7C0%7C637004771040435690&sdata=3DYTc5fOFHEPujyIDR4%2F%2BDEXmBwOw9lBqJ=
5XI8NvJg82s%3D&reserved=3D0"
PRIVACY_POLICY_URL=3D"https://nam06.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fwww.ubuntu.com%2Flegal%2Fterms-and-policies%2Fprivacy-poli=
cy&data=3D02%7C01%7Cjuhlee%40microsoft.com%7C3275e088e3d6452057dd08d71876d7=
22%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637004771040435690&sdata=3D=
DK4jNF2oql4f9EgW5umea6ngRz1vOCEOON3MNK5QSlY%3D&reserved=3D0"
VERSION_CODENAME=3Dbionic
UBUNTU_CODENAME=3Dbionic
root@juhlee-137339034-1:~/rdma-core#

< CMakeError.log file contents>
root@juhlee-137339034-1:~/rdma-core# more /root/rdma-core/build/CMakeFiles/=
CMakeError.log
Performing C SOURCE FILE Test HAVE_C_WCAST_FUNCTION failed with the followi=
ng output:
Change Dir: /root/rdma-core/build/CMakeFiles/CMakeTmp

Run Build Command:"/usr/bin/make" "cmTC_d2ba5/fast"
/usr/bin/make -f CMakeFiles/cmTC_d2ba5.dir/build.make CMakeFiles/cmTC_d2ba5=
.dir/build
make[1]: Entering directory '/root/rdma-core/build/CMakeFiles/CMakeTmp'
Building C object CMakeFiles/cmTC_d2ba5.dir/src.c.o
/usr/bin/cc=A0=A0 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wm=
issing-prototypes -Wmissing-declarations -Wwrite-strings -Wformat=3D2 -DHAV=
E_C_WCAST_FUNCTION=A0=A0 -Wcast-function-type -o CMakeFiles/cmTC_d2ba5
.dir/src.c.o=A0=A0 -c /root/rdma-core/build/CMakeFiles/CMakeTmp/src.c
cc: error: unrecognized command line option '-Wcast-function-type'; did you=
 mean '-Wbad-function-cast'?
CMakeFiles/cmTC_d2ba5.dir/build.make:65: recipe for target 'CMakeFiles/cmTC=
_d2ba5.dir/src.c.o' failed
make[1]: *** [CMakeFiles/cmTC_d2ba5.dir/src.c.o] Error 1
make[1]: Leaving directory '/root/rdma-core/build/CMakeFiles/CMakeTmp'
Makefile:126: recipe for target 'cmTC_d2ba5/fast' failed
make: *** [cmTC_d2ba5/fast] Error 2

Source file was:
int main(void) { return 0; }
Determining if the pthread_create exist failed with the following output:
Change Dir: /root/rdma-core/build/CMakeFiles/CMakeTmp

Run Build Command:"/usr/bin/make" "cmTC_ec514/fast"
/usr/bin/make -f CMakeFiles/cmTC_ec514.dir/build.make CMakeFiles/cmTC_ec514=
.dir/build
make[1]: Entering directory '/root/rdma-core/build/CMakeFiles/CMakeTmp'
Building C object CMakeFiles/cmTC_ec514.dir/CheckSymbolExists.c.o
/usr/bin/cc=A0=A0 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wm=
issing-prototypes -Wmissing-declarations -Wwrite-strings -Wformat=3D2 -Wfor=
mat-nonliteral -Wredundant-decls -Wdate-time -Wnested-externs -Wsh
adow=A0=A0=A0 -o CMakeFiles/cmTC_ec514.dir/CheckSymbolExists.c.o=A0=A0 -c /=
root/rdma-core/build/CMakeFiles/CMakeTmp/CheckSymbolExists.c
Linking C executable cmTC_ec514
/usr/bin/cmake -E cmake_link_script CMakeFiles/cmTC_ec514.dir/link.txt --ve=
rbose=3D1
/usr/bin/cc=A0 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wmiss=
ing-prototypes -Wmissing-declarations -Wwrite-strings -Wformat=3D2 -Wformat=
-nonliteral -Wredundant-decls -Wdate-time -Wnested-externs -Wsha
dow=A0=A0=A0 -Wl,--as-needed -Wl,--no-undefined=A0 CMakeFiles/cmTC_ec514.di=
r/CheckSymbolExists.c.o=A0 -o cmTC_ec514
CMakeFiles/cmTC_ec514.dir/CheckSymbolExists.c.o: In function `main':
CheckSymbolExists.c:(.text+0x1b): undefined reference to `pthread_create'
collect2: error: ld returned 1 exit status
CMakeFiles/cmTC_ec514.dir/build.make:97: recipe for target 'cmTC_ec514' fai=
led
make[1]: *** [cmTC_ec514] Error 1
make[1]: Leaving directory '/root/rdma-core/build/CMakeFiles/CMakeTmp'
Makefile:126: recipe for target 'cmTC_ec514/fast' failed
make: *** [cmTC_ec514/fast] Error 2

File /root/rdma-core/build/CMakeFiles/CMakeTmp/CheckSymbolExists.c:
/* */
#include <pthread.h>

int main(int argc, char** argv)
{
=A0 (void)argv;
#ifndef pthread_create
=A0 return ((int*)(&pthread_create))[argc];
#else
=A0 (void)argc;
=A0 return 0;
#endif
}

Determining if the function pthread_create exists in the pthreads failed wi=
th the following output:
Change Dir: /root/rdma-core/build/CMakeFiles/CMakeTmp

Run Build Command:"/usr/bin/make" "cmTC_cad04/fast"
/usr/bin/make -f CMakeFiles/cmTC_cad04.dir/build.make CMakeFiles/cmTC_cad04=
.dir/build
make[1]: Entering directory '/root/rdma-core/build/CMakeFiles/CMakeTmp'
root@juhlee-137339034-1:~/rdma-core#
