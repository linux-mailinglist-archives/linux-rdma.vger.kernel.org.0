Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08925609454
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJWPVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWPVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 11:21:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A566D9F1;
        Sun, 23 Oct 2022 08:21:44 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NBC5H6021118;
        Sun, 23 Oct 2022 08:21:39 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3kcdvrbc3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 08:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuhKJvR/VymW4GrLycHmh+GS8ClL+vNgXKPqAOaIy+HcAKk30V/Nk53cZqKWsCAFPoidVHXjcgYntmKBcl7A4XfrlqXhf0GsHBBn/MBpFoYjnlAm8vfdAvyaE3bsydsZKX1HDXE8UnZTfNdBN7l2ZPb9BqiQ/L2d4OJ1qkz0qsZDpDblwBuszefH+dybS5XcS6cT3llwvFFNeo7ZGwnJdxNMDyLoyzYvucn4ixbb4DiiLawzEl6yCbaG6nWQXSb2VZb80ibV5/2PydTdh2BJtLExwvpoy0QfzhHZW6CIqb9LJ49hI4BQl6S6XvXXjxBIs5pqysBp0bZ2yj1W/M/77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfHmvaFd6sVzUmJYknC4+56QMDyfL5n1AcqRTVpmMU0=;
 b=SdbP0yJUA+iHqEau0LAA+ujEhlcypMXCJrQGBUAu6dLxt4Kxl7MFFqOK+A/4uPIBk66BeO31oQdAwqMeQ3SWM6NWXs4RMWwKygAFhTfLJ/cJhhDkntGmUWLVS2DbqgQezEcIKilEoCDFvQR/Vz3J9VCzro0ZmeFaJJG8tOw+AIU0hTaB6EQURydSPsWttLFkgfQznZdWmDje3e3bZBNa4VGP38nhkYgCqrOPQBmq8uHWJ05vr6UNxipwGKIk8iezsRrzLZD2ZMIOeGK07Ozos7+5Z2D/zgpxPgJVa8UDBS4vT+2Q9buzNKJHOAtfMyiU8jiNKR3YqL6IVUtd3rK/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfHmvaFd6sVzUmJYknC4+56QMDyfL5n1AcqRTVpmMU0=;
 b=c7E8Wq0k3utKVhGQ2ztX3xeEK8mWpO4WKK409GA4Ulgk1CmQSKJMSOKSfUXH0A5OLV/nvxznF75MzFr0bfP0bh586ZdW7r+KunueLlkewwwwohczOwHqs0hg+A3B2KGxj+In5nXNR1Fd2QeIW1Lvg0RXp8XGRGCAUbgMDwzW+K4=
Received: from MW5PR18MB5199.namprd18.prod.outlook.com (2603:10b6:303:1ca::16)
 by SA0PR18MB5256.namprd18.prod.outlook.com (2603:10b6:806:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Sun, 23 Oct
 2022 15:21:36 +0000
Received: from MW5PR18MB5199.namprd18.prod.outlook.com
 ([fe80::6660:188e:7728:73a5]) by MW5PR18MB5199.namprd18.prod.outlook.com
 ([fe80::6660:188e:7728:73a5%2]) with mapi id 15.20.5723.033; Sun, 23 Oct 2022
 15:21:36 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     wangjianli <wangjianli@cdjrlc.com>,
        Ariel Elior <aelior@marvell.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] infiniband/hw: fix repeated words in comments
Thread-Topic: [EXT] [PATCH] infiniband/hw: fix repeated words in comments
Thread-Index: AQHY5dqUI1+komj6MkasjlbJdcJhaa4cGn5w
Date:   Sun, 23 Oct 2022 15:21:35 +0000
Message-ID: <MW5PR18MB51996A3C30850951FFFE018DA12F9@MW5PR18MB5199.namprd18.prod.outlook.com>
References: <20221022055257.42905-1-wangjianli@cdjrlc.com>
In-Reply-To: <20221022055257.42905-1-wangjianli@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWthbGRlcm?=
 =?iso-8859-1?Q?9uXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?iso-8859-1?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNWZmOTQ1MjEtNTJlNi0xMWVkLTljM2?=
 =?iso-8859-1?Q?QtNTA3NmFmMzM2Y2NkXGFtZS10ZXN0XDVmZjk0NTIzLTUyZTYtMTFlZC05?=
 =?iso-8859-1?Q?YzNkLTUwNzZhZjMzNmNjZGJvZHkudHh0IiBzej0iMTI4MSIgdD0iMTMzMT?=
 =?iso-8859-1?Q?EwMTIwOTM0NjM3MDM0IiBoPSJNWmFXenNqQXMvamYvL3pZUGtQb0d0OGp4?=
 =?iso-8859-1?Q?bHc9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-1?Q?ZOQ2dVQUFQNEZBQURxZlZFaTgrYllBVGN1M0ZVbUZnUEdOeTdjVlNZV0E4?=
 =?iso-8859-1?Q?WUpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDT0JRQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQTZQcWVsQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUo0QUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-1?Q?FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJsQUhJQWN3QnZBRzRBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0Ix?=
 =?iso-8859-1?Q?QUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFBRzBBWWdCbEFISU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQU?=
 =?iso-8859-1?Q?c4QWJRQmZBSE1BY3dCdUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW?=
 =?iso-8859-1?Q?5nQUFBR1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJm?=
 =?iso-8859-1?Q?QUcwQVpRQnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpB?=
 =?iso-8859-1?Q?QnNBSEFBWHdCekFHd0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQU?=
 =?iso-8859-1?Q?hNQWN3QmhBR2NBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQm?=
 =?iso-8859-1?Q?ZBSFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZ?=
 =?iso-8859-1?Q?QWFRQnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZB?=
 =?iso-8859-1?Q?R0VBWkFCa0FISUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBd0FBQUFBQUFBQUFBQUFBQVFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSF?=
 =?iso-8859-1?Q?FBWlFCeUFHMEFhUUJ1QUhVQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-reftwo: QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR18MB5199:EE_|SA0PR18MB5256:EE_
x-ms-office365-filtering-correlation-id: 6fe6e3a1-9bef-4fc0-081d-08dab50a4640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZgzXyYxamPF2iqtHqqMHgiUXuS1gmm0yxzpwY0bs64Rjsooih4DU/0GqAX77D72BgHlVADJ3sHbEg1w2vTMHTJopyCvC4xrbUWRFprLVSZ33uHNzk2wcVB0mpGDtPAiHBA6Fpo1wh8j1eXs8n3WaWdFev/hYgwu+2Ag2WFQYfh4LzRH5lZBaBNpdu9Wi/KYJeW6jdWrJ/LrZZNzPpuRUfOmMZX5blhuE9pzTUbos6zoLc7ay6SSr2Vg9t5paOmTwx1iTD6KcfdHy5KFom7ubUSchwVq37T5LCVKADscpS+bp3XPwTz1Dv215pclrgscur4xFNT4vP6H5Hd7AzeBOH+ff6gmDnCQExBkdEhrBg8BZBEi2LoRJe3WQ22cbiyVGnTnvyShUFQ4naPW++xA5VbMMntRih4jWifsNOma7P+mAXqO0SojSNu+swYkdTp4S9gPAgm4b/P/MTrdqRVcYQjy0yWEqmGd4kS5ZxFzb+2BOUfHvo/pnK9FknNm3RDw7k4bRMpaWafRdPj14A/q/1QGr1dT7YmzFtNiUKhnECBHxo+DZDxYe0Y4glBbUIgGgsdXe1h+WGR1Q4GGuVDjopmv8ev9Qxa7oF0FnJWcp8vFpmWIYYeFNbSeGlr59XQTSTuwPHGsAKysK2bsq6fzfE/iNIcIc6x2+Ui8iuPiYc+9LPjFQNrlHAbXIPG8rbRno/8PgCFcsYqTrqkdKTKhlu5NE5+Yi5SItJX/fof+ebHmsPmFmvTjY837jKNCkuRp61HAf+XpJD9b/GWlTaYNUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR18MB5199.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199015)(86362001)(38070700005)(6506007)(186003)(83380400001)(38100700002)(66446008)(122000001)(7696005)(2906002)(52536014)(41300700001)(55016003)(5660300002)(8676002)(9686003)(71200400001)(26005)(8936002)(478600001)(66476007)(316002)(76116006)(66946007)(66556008)(110136005)(4326008)(64756008)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g96+wVZ2P8j2sI0sSOplkpOJCLWnUtb5EnfInXSIOeWMqPxvhvnDw96+NE?=
 =?iso-8859-1?Q?G+lMfCAN239J+N9C7XwQQKDRgNUMx3oJrhDb6KXlZzEpwGtbk/bfOzBleX?=
 =?iso-8859-1?Q?K7stD6pUWppC0igC5cN3gSmfza/MVuZLoljX2mDAZOhEyHDICV49XBH5iS?=
 =?iso-8859-1?Q?OZj54+no6bhhpAjW/+xFvsblMxIu1ZnWgmwGxH8g4W6Jc4Q/pDHQ5ZeKyC?=
 =?iso-8859-1?Q?ZQiRo2DikyysGJaduJwZpQ48p3zsGIwVs+UvQPiDw9Q/Ium6QHqSX9k+ml?=
 =?iso-8859-1?Q?9762Fe/MOt7F+bfr+73kEwA8TtzFObzKeiIh27tbSeP5ZcybN3gwTrKkpT?=
 =?iso-8859-1?Q?+gMAn4ygC8KzgT9fojMpn1oW/UCqBXatvbBCqQaXALq373FXJc5QSoUbUq?=
 =?iso-8859-1?Q?W77v9M8KqIQyMOn29FrJ2oeYkqdt3wHo1zVWee53MQ51a7rQwPvQztfIVT?=
 =?iso-8859-1?Q?dU5fVxXQ6UXjWwcL6JbI1yB+7xwp77TCMsiKnvqsEIrGStgWph/VEaHvbd?=
 =?iso-8859-1?Q?EAj3/uHDroCSIgQgnwg9j3jliSoaSVd/AR+d6EaJeTyxvgvkmqm0qiqRR6?=
 =?iso-8859-1?Q?52yBe4xcJVL62i7dKe9QlDOfxv1/toNLyDUdbbO3gxYISy+UDZcivvP5pV?=
 =?iso-8859-1?Q?kgdBj+YORXddITIu0nnsGN6ccS0AmhNA13eBDeT5/nXR5a134/nfXfMVCn?=
 =?iso-8859-1?Q?yleI0fehZ3T5mhZaRVoF6alTRSMH/nkSP/HyGmO0JLnkfECfpC89INUtdf?=
 =?iso-8859-1?Q?vYeU0MreSpJsjCfAMFdNdbth2M713J44Mnoe0InmrLu46lZ1hCkKhUeuVZ?=
 =?iso-8859-1?Q?0qMQN/eS3rJXoEwLjwhwbjRneCpdxAE/Z1Cqnewo7brM3EBTb6zrN+5swa?=
 =?iso-8859-1?Q?kRdnkJRLd8Ab1ZNG0ynhgTTQ1FNYk3i2fqftKisSo4EXUkv/9Xhvmi0XdK?=
 =?iso-8859-1?Q?lrCOE0a5UJKLp4snpk7nZn0I0cdqhDNGEBpV/xbKnTmjIcoNc+EFJD61w7?=
 =?iso-8859-1?Q?L93DMgDSsJZ4hN79yWhBnx09jz+5W8SCKK3YXkCMb6mYq9+CQvTg6nkxfr?=
 =?iso-8859-1?Q?hiH397pidtr7jP+i+OcRfHL1jmpZ2ouacMrDECgaPg2ZWqHUwV++2sEHLA?=
 =?iso-8859-1?Q?0H6bqK//khtkuM6M3wPya4Ow+rspUNLQ+kRWo5bLPM7eBBB7Zbvs5EgnGr?=
 =?iso-8859-1?Q?Zw2rcHZuXYX2DI16o/vrOFt/4UnqZgTOzEsQFk5Qs66JL8Z0RpOaFb0SZj?=
 =?iso-8859-1?Q?73VpRURtltmMsrQ2pJaK9Dr3vHA+EAP/6PKUc92erHyJHgysMf7wlo966r?=
 =?iso-8859-1?Q?OjmROUrTTu2BLei7+PE7ebtrXc8NECDZmwgEH1k79Xbnqvr6+28/zL2qA+?=
 =?iso-8859-1?Q?r9/0z4wQH48JisCjgOr94SjZk6Qrltpj9O6BVW7ciZpXy1yHNEa0yPhOnB?=
 =?iso-8859-1?Q?iof5pMif08ZqThLrHIeyzIkOiYeuarNTYbnjjHC5Tm5WidOTSsllguueG8?=
 =?iso-8859-1?Q?nYph0BBA5n7+tyP5UAzNJS1PvmZMYgBxIa7M48OgtGIxPUVlr7Pf52pQOh?=
 =?iso-8859-1?Q?lpxhgwt7rmOnF7lEs56RcTXtkGH29g+f9h19zrpDeginx3WhEjg0HPKajM?=
 =?iso-8859-1?Q?fU4VPv+w3F0JYK8hFiI6rzESklTKB9ViF2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR18MB5199.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe6e3a1-9bef-4fc0-081d-08dab50a4640
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 15:21:35.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8Fogocj2QW9yVj6pLkXsWqJSIAchgB+Z7SLkO2iXuVxyXy8joEBwuG/jroAdtGe2Nl7NlSHfRCv/lmqjw62ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB5256
X-Proofpoint-GUID: c88rsKtfXd4eyuYIdgWgEmLHz61fJQKl
X-Proofpoint-ORIG-GUID: c88rsKtfXd4eyuYIdgWgEmLHz61fJQKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: wangjianli <wangjianli@cdjrlc.com>
> Sent: Saturday, October 22, 2022 8:53 AM
>=20
> ----------------------------------------------------------------------
> Delete the redundant word 'the'.
>=20
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/main.c
> b/drivers/infiniband/hw/qedr/main.c
> index 5152f10d2e6d..5e7069b76d46 100644
> --- a/drivers/infiniband/hw/qedr/main.c
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -472,7 +472,7 @@ static irqreturn_t qedr_irq_handler(int irq, void
> *handle)
>  		/* The CQ's CNQ notification counter is checked before
>  		 * destroying the CQ in a busy-wait loop that waits for all of
>  		 * the CQ's CNQ interrupts to be processed. It is increased
> -		 * here, only after the completion handler, to ensure that the
> +		 * here, only after the completion handler, to ensure that
>  		 * the handler is not running when the CQ is destroyed.
>  		 */
>  		cq->cnq_notif++;
> --
> 2.36.1
>=20

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


