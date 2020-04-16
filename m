Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA31ACFFD
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgDPSza (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:55:30 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:11780
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbgDPSza (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:55:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1+iJlU4vBEWHB+wjqCuB+0ih55tGtDXyika9QgmY57vb8+eTbJ3rpT/0E7dvKpHsCmLUUR+lmf9QWjp9J1W8KauTkZHeJDwtO53v7ai5gBNRZscObT9GquZeJUrvVYiM41bim4JisIKdaHza9F0s36oijGvxsKJHQnN8/mclcT5Htj3x9wDftgCiog4AvqzUaehu4lxsSo2HYMXxPVfQPTTMThaORrbHyixBSq5E5ik95KxqWeB7MU6ly74FkOzF1VLKoj0qbIpaHYqd4YH5AhGPoRzX8meg3MGZ5f5I0/1CG98IQpkaDMED9yXIV8BoSMGxDWiSn0LYO5hB0mR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2X8LJzYtlOpi37tfAMVXyCBiNJ+q241jUd3ya2aKFE=;
 b=U+S2GtOJREsQgkPkY3jegQfNolZMoww69+mAAC0fBBrGYAFC3cvFNYaqCaOSNW0srmvCTwWvOcYJUiWwBJ+eQh1Z6O8i6N+fJB7smrNsVeOmlcOxS24uAA9uqYYGHwvGXwL3sJlzWcXZFB7KlkTB0/pDoXlYrr6eYpJ44EwknWWzyVm9G+B7Qc7qpvyW0utVXlz5zINLS091fjNlEbs9olI74O7YOXWVHcaVYWHzw7oIiwWLbZoan+PJWug9bWQF80yfhhlzWTUIN2lvF9Kk8UUXVfR1I1MHSdiZyRX1KcJ8R1BAb8aTqtH/Ynyw1P6cM52g2OvMnr2ESdGLXGh5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2X8LJzYtlOpi37tfAMVXyCBiNJ+q241jUd3ya2aKFE=;
 b=K7icd4Tk83PCxFMq7dB1XH7oghfyBVwzf2u4uZepEmin/0amGDRYt7kPZste95eM5r+MSeFfFk3I/hPKWI0ylrJQLxfOjkuCiE7+OCKReSCaopxYtmKZJK66LiXuz9L5arZjpLlM1FS8WVBe5Atidumv1H4mGAat61Vg+QwjeSU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4302.eurprd05.prod.outlook.com (2603:10a6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 16 Apr
 2020 18:55:27 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 18:55:26 +0000
Date:   Thu, 16 Apr 2020 15:55:22 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200416185522.GA11945@mellanox.com>
References: <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
 <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
 <20200414125012.GK11945@mellanox.com>
 <BCFFD1E1-F013-4B09-9DC5-5A4EE205EA10@oracle.com>
 <20200414161141.GL11945@mellanox.com>
 <3168883E-169E-4D96-A4F5-8FF882B164BC@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3168883E-169E-4D96-A4F5-8FF882B164BC@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0011.prod.exchangelabs.com (2603:10b6:208:10c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 18:55:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jP9fW-00072j-UB; Thu, 16 Apr 2020 15:55:22 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b33f88f7-131a-49fb-6f4c-08d7e237b9ed
X-MS-TrafficTypeDiagnostic: VI1PR05MB4302:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4302740C125B2EEBC16C535ACFD80@VI1PR05MB4302.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(1076003)(33656002)(52116002)(2616005)(4744005)(86362001)(66574012)(2906002)(5660300002)(8676002)(81156014)(26005)(9786002)(186003)(8936002)(9746002)(316002)(6916009)(36756003)(4326008)(54906003)(66556008)(66476007)(478600001)(66946007)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12vsaMWV/ogILhXjdpESRtKwncdY10xT+E17QX4jDY6a2BcDHc+8v9lvngkgIcVgVe5SGeLMwED1l6TqR8vuTo9jWkKQUtEOoQrmObCOA1Stz7q+QZmH/W3tIO30LpnwFuqeTerzzk7mKG45VCuQPkhWe5uH5B+Q23qJg5wRpCYcdc3asAPjtWgLFxSZBS38NKn6CCz8g+S7+SIEwkPPD2no3igaSgkIoUBVM+nPLeuKstNCq4KGTxz74+0N8HwNvuBV4xRHjXgK7EHeAAJQjSTbk4r70cOtNiOYH3ikfFly9eLhRp6bxvg7ztp0d9sGxOAT6Jz0B9Vb4niKBAd7oRbmlO6nBRgP8VAwJ5+tjLSqzR8UK7QO8cCy710YpT1X8Cf4RXt0q9WQXaVqQVoq41DwB9x9Nt7WMdGEjDJmaD1Dkp7Y5w654WD1Zm9mDzwlazbThPVMPxXgj5wPwI8Bqn19ld06+h6y0gqhlypixHRQjmVPfMzxzajMspadOAOV
X-MS-Exchange-AntiSpam-MessageData: GLvfY+qjmiB5arTs2KERIhlneyHEm4gB9tPLrOEXWBtAuC5FwbuKPCLV3fPxkOs511UwaikNxYlkLqIj9RSy7hR6lDa56elyxmYbhud2FSjMUTgNzGXM824P93/w+21iq40fRncXOed2YjFW0xXxnQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33f88f7-131a-49fb-6f4c-08d7e237b9ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 18:55:26.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsOQ9XafqVuS0tP6S9vvs66xuZcQYNuX78im8foBpdq4SYvYVBUJCnY/ytJG3aVGnFhQZqwNyehjVJW4kR3x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4302
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 03:33:28PM +0200, Håkon Bugge wrote:

> > I think the trick is that ucma_event_handler never returns failure
> > unless RDMA_CM_EVENT_CONNECT_REQUEST, which means the cm_id isn't in
> > the xarray yet?
> 
> Sure does. 1 or -ENOMEM. But the ULP's event handlers isn't that
> polite. But a different issue from this syzkaller one.

Seems like a crazy and difficult API to me..
 
> >> I assume the refcounting takes care of this.
> > 
> > There is no refcounting for destroy, it must be called once.
> 
> I was thinking about the "cma_deref_id(id_priv);" stuff, but I may have misunderstood.

This just causes destroy_id to pause while a ref is held, there can
still be only one call to destroy_id

Jason
