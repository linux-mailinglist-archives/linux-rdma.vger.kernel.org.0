Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F707B2C41
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 08:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjI2GUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 02:20:40 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA319F;
        Thu, 28 Sep 2023 23:20:38 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T273VK031730;
        Thu, 28 Sep 2023 23:20:08 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3td7y6v08g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 23:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRjTDAwn/NYvbIZFlg7IKMPaKANaZkigjitvrKMTKCYgGGowwZvil/6AmoyCNurBJy6KAX1tL05akV9fwBMSUH/QfzvP+GHAVcLy39Wc9ATQT+NVdiXslygeOPWliuGSmIotpuXkA3kiVLL/d4QObb+A3afBtBk3gmHI31vgHjWrQw9XyAJ3O8FHWc1f7GKjmBNmJby7hSO4i7z7ImYK6WZ8i3TskLP32ZQCQS74ywXg4HAcgfFn5EkMXfKCo06jZEfIJnU0sxXveejyIQhUF66mtU+ECEWpQU6zukKsiwS25qtY4M9U+rkbETqLCpmRPe212xRvaizglLP9nwo4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrtZdKZN2CsCLvDC/YxRqyDU8YpsWdXL9IE18cmzSdw=;
 b=nyadD7SM3WW0yWoH4sJujPwc8n5LtmbLp4mhVzoqW5kJ2x6/ED8pz94mSWwMbiie7jM93i8ECr/pFFtRtBNN3JOdgGUtgcpegezgT2ghJ5B+Lh3ftOJIBNklpoE4eqirlHuIK4dTJWJ8iiD0TyOuPzRxG4WcQJ3zKRBZBURWRnfcLkXOIWiuYV3V8892mF4fwPqwZcTZrAMj/3C2jGfWPqS7PRfqLvXkr2gJfZYnirjjyOT4XQAr3C/+ycbbmgfKgb6X/NlvxAwc6H1gWoPU/A0zt6sB5FxCxTBL92isKcjT0QnoqLbBgE17svzW8AqLAVOs4zg3NrYChmWfkXNOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrtZdKZN2CsCLvDC/YxRqyDU8YpsWdXL9IE18cmzSdw=;
 b=QKr+WKur8duvMDJzMBecFcMNfzwFU03eU9qIX3a6ht3yE3Io3lu9WIhAd1mh51tM/UOs1e0HyHg07gQRGNr2uYbZ+yOETB7Px/h2aAOakJmNMBUq/yVtWlkppnsOfP8nOND80Kxk2SOg1H/kzG7BVkTtOZ9f17O6XTPUxsr+62M=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by SJ0PR18MB3948.namprd18.prod.outlook.com (2603:10b6:a03:2ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Fri, 29 Sep
 2023 06:20:06 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::9caf:dc2e:a8d7:b5c6]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::9caf:dc2e:a8d7:b5c6%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 06:20:05 +0000
From:   Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "borisp@nvidia.com" <borisp@nvidia.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sebastian.tobuschat@oss.nxp.com" <sebastian.tobuschat@oss.nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only
 when update_pn is true
Thread-Topic: [EXT] [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN
 only when update_pn is true
Thread-Index: AQHZ8eh3hbvedhmCRUmmM4+XCFyv7rAxVNxQ
Date:   Fri, 29 Sep 2023 06:20:05 +0000
Message-ID: <CO1PR18MB46669352C6BA72CEDF44993FA1C0A@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20230928084430.1882670-1-radu-nicolae.pirea@oss.nxp.com>
 <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20230928084430.1882670-6-radu-nicolae.pirea@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2JoYXR0YVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTM4M2Q2NjQ1LTVlOTAtMTFlZS05YzZiLWJjZjE3?=
 =?us-ascii?Q?MTIxOGI3YVxhbWUtdGVzdFwzODNkNjY0Ni01ZTkwLTExZWUtOWM2Yi1iY2Yx?=
 =?us-ascii?Q?NzEyMThiN2Fib2R5LnR4dCIgc3o9IjYyMjIiIHQ9IjEzMzQwNDQyMDAxOTQz?=
 =?us-ascii?Q?MTUzOSIgaD0iNWR0aHRKUGcrT0sxRU42ZFEvZXE4ZlgzaVNNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFC?=
 =?us-ascii?Q?enFMbjZuUExaQWFiV01OM2VqYUtjcHRZdzNkNk5vcHdaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBM2c4QUFEb0dBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFGd0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBVUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQU9nWUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUFBQUFhQmdBQUdRQUFBQmdB?=
x-dg-reffive: =?us-ascii?Q?QUFBQUFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFBQUFBQVl3QjFB?=
 =?us-ascii?Q?SE1BZEFCdkFHMEFYd0J3QUdVQWNnQnpBRzhBYmdBQUFDNEFBQUFBQUFBQVl3?=
 =?us-ascii?Q?QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJ?=
 =?us-ascii?Q?QUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0Jr?=
 =?us-ascii?Q?QUdFQWN3Qm9BRjhBZGdBd0FESUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFi?=
 =?us-ascii?Q?d0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1BQUFBK0FB?=
 =?us-ascii?Q?QUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnVBRzhBWkFC?=
 =?us-ascii?Q?bEFHd0FhUUJ0QUdrQWRBQmxBSElBWHdCMkFEQUFNZ0FBQURJQUFBQUFBQUFB?=
 =?us-ascii?Q?WXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdCZkFITUFjQUJoQUdNQVpRQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFQZ0FBQUFBQUFBQmtBR3dBY0FCZkFITUFhd0I1QUhBQVpR?=
 =?us-ascii?Q?QmZBR01BYUFCaEFIUUFYd0J0QUdVQWN3QnpBR0VBWndCbEFGOEFkZ0F3QURJ?=
 =?us-ascii?Q?QUFBQTJBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3QnNBR0VBWXdCckFGOEFZd0Jv?=
 =?us-ascii?Q?QUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdVQUFBQTRBQUFBQUFBQUFHUUFi?=
 =?us-ascii?Q?QUJ3QUY4QWRBQmxBR0VBYlFCekFGOEFid0J1QUdVQVpBQnlBR2tBZGdCbEFG?=
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBWEFBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
 =?us-ascii?Q?a0FHUUFjZ0JsQUhNQWN3QUFBRmdBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?WHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZB?=
 =?us-ascii?Q?RzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFB?=
 =?us-ascii?Q?QlVBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJs?=
 =?us-ascii?Q?QUdRQVh3QmhBR3dBYndCdUFHVUFBQUJhQUFBQUFBQUFBRzBBWVFCeUFIWUFa?=
 =?us-ascii?Q?UUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFI?=
 =?us-ascii?Q?SUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFITUFBQUFnQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QmhBSElB?=
 =?us-ascii?Q?YlFBQUFDWUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdjQWJ3QnZB?=
 =?us-ascii?Q?R2NBYkFCbEFBQUFOQUFBQUFBQUFBQnRBR0VB?=
x-dg-refsix: =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUdNQWJ3QmtB?=
 =?us-ascii?Q?R1VBY3dBQUFENEFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FHa0FZd0IwQUFB?=
 =?us-ascii?Q?QVhnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0Js?=
 =?us-ascii?Q?QUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFi?=
 =?us-ascii?Q?Z0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBR3dBQUFBQUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JoQUhJQWJRQUFB?=
 =?us-ascii?Q?SElBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpR?=
 =?us-ascii?Q?QmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0?=
 =?us-ascii?Q?QWRBQnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0Ju?=
 =?us-ascii?Q?QUc4QWJ3Qm5BR3dBWlFBQUFGb0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFH?=
 =?us-ascii?Q?VUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFB?=
 =?us-ascii?Q?QUFHZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpB?=
 =?us-ascii?Q?SFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHOEFjZ0JmQUdFQWNn?=
 =?us-ascii?Q?QnRBQUFBS2dBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFkQUJsQUhJ?=
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUFVQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|SJ0PR18MB3948:EE_
x-ms-office365-filtering-correlation-id: b1262366-ad1e-4856-8d5b-08dbc0b41f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBe21uVB2ui+Ch6/4qiJXO73dvfidpBbnf9DZGgqHYuWP6QIS9e6GQJ8osWvgKmwLgFWuC8vWAn8w6FI5pxfS9TlQF3Mh8Ynbvr04VvG9fkszhRxGCMtaQ97vN46i3pGNn5cUNDPVUinsBoDrOXl51NLDyFK24+y+9yNN+VLuOBkVHROFXj26g7zKlssN2Fyr4RDGSMd+Xvd5miRGf/wU7GU6Ue9/6bQZTDvBWfzrwIpDLYJhpX5pE3UpBjHNd2lzLgRsd76+Nh78aJcjgHdzZ0RLAMmJGsufKvNxb6IppU3Tv8M3wS19MEs+1ntzLV4t5aBWevGBKKKxmBtqVWFYXEtfG8sa2jmkOc+HmVeuXYOXzsJOl52yOolM+gmxf+0B+7DnBiJqoC20OiB8SYgPg5NogTtXrcnlH2YaWxmIWdtoB6lAX1XLPkWAGPjuJ2v98oqlnvsfu6jJMV3QdbHdbnrYeoXza1uGO26OFySowOuAXgD6QMCN6oT6wT1M3sfH/4kPsFqrxysU5Uuk1Yq3nzC8YYu2hdCNdTX7y8UTjU0354gPtlOGkUVB4+u2SdOboLYXCNF4YdwtdJSV/CD0gATjykepS2cAwuczUBAMPSb3wcQCu9sKAp1OOggFsu6+ukUCTu/Ff/LTLi8HWaFlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(9686003)(55236004)(7696005)(6506007)(71200400001)(86362001)(83380400001)(921005)(122000001)(38100700002)(38070700005)(33656002)(55016003)(26005)(8676002)(8936002)(15650500001)(316002)(66946007)(41300700001)(76116006)(66446008)(66556008)(110136005)(64756008)(7416002)(54906003)(66476007)(478600001)(2906002)(52536014)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ybV5nqG66mCcJaf4+Ui83hXZ5EHvjoFmohFJuk1qmGCabrPvpITRuxyVdmIj?=
 =?us-ascii?Q?52bnbhWTSwTqf7/jJDmXBsjAxfe4+QC6BWhqip0+422YQU4YtUWwzitEixFi?=
 =?us-ascii?Q?e2WUycVtTvoQh3A31QTNtzunjj+3YyYT19uwW2D66S1r5KwUScTAKjAuZ7i/?=
 =?us-ascii?Q?+sl/8NS3zkXOQzsN9M3k9xmfWPDUDyivlOZWtAPN4o6bE9UjoIYTyBTDjVXX?=
 =?us-ascii?Q?STHjYsO3/fYnXri44Ug0+vy3mBzixLf5aPIu5p8bqohkWh5SMzyEU8xRM64r?=
 =?us-ascii?Q?rA/YI9ZmWP62j2+WZ+gLvFxnABrmY5cvfuW6m4YSv8loAQLID/qkoSpQmqpN?=
 =?us-ascii?Q?xcey97fvIqlkrBCXCZHaz4/0u0El7ta+xhdmwtdSiThthXI5Mu0kz3/uwoYf?=
 =?us-ascii?Q?e2MIpcpdoP1cM593B4tyOUfJ6nvW5bhRGdH8nbs4zwaKfh8QSvrlLQrbAZOq?=
 =?us-ascii?Q?NyNSsD36ohNPidC9940p+mUIAbH+qZJ0BObJKdGo17fmMGIUx2OJ2jfMTsOU?=
 =?us-ascii?Q?msgzJ3X65As5a9tA7nAY9CZXIFOKZU3Y5OCREAz8H1y4BM83p71oSnAJK8BW?=
 =?us-ascii?Q?3bWPTLl5/H1H+h6Zmt5eXrneeu5Q/Pz/PUYUO7KgrWdWzIIdkuTRLVOonje2?=
 =?us-ascii?Q?DSCZ3cmDxht7cunl2YcI6jJV3a9fo6aIUIidiiHuLpp7fYna0/Gph5KprivN?=
 =?us-ascii?Q?dhjOgxRJNl2BUq6Wc3K2Nu8YsYFiLyVKWAREH8awkUH40T8MDgT8DrCtn8Ui?=
 =?us-ascii?Q?rL91KXwhufRuMQMuzI4loe1TxVBKUuOy0pXZETp+XlH9oLVHCRT01tIEfKtj?=
 =?us-ascii?Q?Q6NSF5cGuvFmfn7Ds8bO9ZwEGnIeQUruMaJAGNYSgeiSwXdCPjCvVhqs3JZ2?=
 =?us-ascii?Q?W7nfNP5UpHcjZMRDvrOY5Hfm76dpt6/qu5a+OTUqEtpKo4YIyQxAQHTbC0zS?=
 =?us-ascii?Q?Q1SUFesPFa9Mpndez0BXL+HFeBNN7juNtoh7qOgsIusbzhP6R8t/ykaCV6kJ?=
 =?us-ascii?Q?79fZfSfjWo24mVFwYkXjBz2VIxZBn1bZGDhyCPXwOVqDBy8xMsUCvap+inZ3?=
 =?us-ascii?Q?q4kTAQMfns23WIAHo2WsUbbEIUKxyw6sESwQhfh1T7tW+DhoRrpgTZH808Gq?=
 =?us-ascii?Q?7J4XVo7qjxcgCqWZBlpeZXlyzPrw4UjlVG5rVjUk4ig/myMNjAN7ifdGbduv?=
 =?us-ascii?Q?RgM8p6/qYzyGdXWgNnq8Pzeku9FJhZQtH0DJqbTm44sUvTdxyxyRzajeNUFM?=
 =?us-ascii?Q?sDw8oemR9UOaYXy0JUq8Pp2QbRu9Z7TaagJ4yxy9Xtroiitl1cYsL1wyEcNe?=
 =?us-ascii?Q?g1u948abyHCosdisBovTYjf2CWxl1Xa/N1I59DGiSv3rqUc19rgciBYEMZxe?=
 =?us-ascii?Q?Yo0YCYMhSztV3QhtbDVpdJPoaRzLKav4NHSyrtpgRj5DaDBwOt/p6hA/8Y/z?=
 =?us-ascii?Q?7H6e1H5e8heeuPQaOuvcQE1FzWUrh3cQ3Rkh0256pHh17zPH9P9/tP9PYMpv?=
 =?us-ascii?Q?CJ8/tdvepHZ1qm3U579QXAS8laXnR/vm9wik/OTYNjsI/b5GVd2w+1qEQbQo?=
 =?us-ascii?Q?liW5Cn3rdvnQEdBIci0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1262366-ad1e-4856-8d5b-08dbc0b41f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 06:20:05.8584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlvhAK27BPmL7MeYvKElDS/S8utylUyAA3ifQNCeaoso10pR1o9OSdi3Az7+zcSl+S7yW06+beIo35XZBsbnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3948
X-Proofpoint-ORIG-GUID: jH8icAXw_QTjKtv7bwtCe06wAujocE7Z
X-Proofpoint-GUID: jH8icAXw_QTjKtv7bwtCe06wAujocE7Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

>-----Original Message-----
>From: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>Sent: Thursday, September 28, 2023 2:14 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>borisp@nvidia.com; saeedm@nvidia.com; leon@kernel.org; sd@queasysnail.net;
>andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk;
>richardcochran@gmail.com; sebastian.tobuschat@oss.nxp.com
>Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; linux-
>rdma@vger.kernel.org; Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com=
>
>Subject: [EXT] [PATCH net-next v6 05/10] octeontx2-pf: mcs: update PN only
>when update_pn is true
>
>When updating SA, update the PN only when the update_pn flag is true.
>Otherwise, the PN will be reset to its previous value.
>
>Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>---
>Changes in v6:
>- patch added in v6
>
> drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
>b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
>index 59b138214af2..4c59850dfddf 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
>@@ -1362,6 +1362,9 @@ static int cn10k_mdo_upd_txsa(struct macsec_context
>*ctx)
> 		if (err)
> 			return err;
>
>+		if (!ctx->sa.update_pn)
>+			return 0;
>+
This is incorrect. Please change it as below:

@@ -1357,10 +1357,12 @@ static int cn10k_mdo_upd_txsa(struct macsec_context=
 *ctx)

        if (netif_running(secy->netdev)) {
                /* Keys cannot be changed after creation */
-               err =3D cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
-                                          sw_tx_sa->next_pn);
-               if (err)
-                       return err;
+               if (ctx->sa.update_pn) {
+                       err =3D cn10k_write_tx_sa_pn(pfvf, txsc, sa_num,
+                                                  sw_tx_sa->next_pn);
+                       if (err)
+                               return err;
+               }

                err =3D cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
                                              sa_num, sw_tx_sa->active);

> 		err =3D cn10k_mcs_link_tx_sa2sc(pfvf, secy, txsc,
> 					      sa_num, sw_tx_sa->active);
> 		if (err)
>@@ -1529,6 +1532,9 @@ static int cn10k_mdo_upd_rxsa(struct macsec_context
>*ctx)
> 		if (err)
> 			return err;
>
>+		if (!ctx->sa.update_pn)
>+			return 0;
>+
This is correct.

Thanks,
Sundeep
> 		err =3D cn10k_mcs_write_rx_sa_pn(pfvf, rxsc, sa_num,
> 					       rx_sa->next_pn);
> 		if (err)
>--
>2.34.1

