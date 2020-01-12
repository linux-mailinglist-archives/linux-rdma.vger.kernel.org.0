Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7FB138561
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jan 2020 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbgALHva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jan 2020 02:51:30 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:13173 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732312AbgALHva (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jan 2020 02:51:30 -0500
IronPort-SDR: noxj3EU7pRV3hcWemDTl1kzyWrcDqb5sDbbyXQ8t5N3mYYtJqWyRiXO5aPIp8qigI2HOsGjEVj
 qQYc2vgqddtQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AcgPWSxaJpusgXTxBuic3fGP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8W6bnLW6fgltlLVR4KTs6sC17ON9fq+BidZvN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdu8gUjIdtN6o8yg?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDI/923Zl9B/g7heoBOhvhBy3YnUYJuNNPp5ZKPSZ88aSn?=
 =?us-ascii?q?RYUslPUSxNG5+xb5cTD+UbIelYr5fyp14Qohu4GQmgHf3gyjlRinHx2q061f?=
 =?us-ascii?q?ouEAHf0AM+GdIFrXDYodvpOKsOVOy4yrTDwzfeYPNMwTrz5ojGcgo/r/+PQL?=
 =?us-ascii?q?x/ftbex0Y0GgPZjFiftZDpMy+J2ugTtWWQ8upuVfioi24iswx/uCagxtsyhY?=
 =?us-ascii?q?nTm4kaylfE9SN2wI0oItC4UFB0YcK6H5tKuSCaMI12Qsw5TmFooyY10aEJtY?=
 =?us-ascii?q?SncygNzZQr3R7fa/+efoWO/xntV/6RLC9miH54er+znQu+/Ea8xuHmSMW530?=
 =?us-ascii?q?xGoyRFn9TKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWc18r+ums6+T9fLrmooOQOoBuhgHgNaQhh9awAeo/Mg?=
 =?us-ascii?q?gIQWeX4/qz1Kb78U34RrVFkOE2n7HHvJzHJ8kXvLO1DgFJ3oo59RqyAC2q3d?=
 =?us-ascii?q?oYkHUfKVJKYhOHj4znO1HUJ/D4CO+yg0yynzd32f/GJLPgApLLLnjMi7rhfa?=
 =?us-ascii?q?195FVAxwYp0d9f4JdUBqsBIPLwQkPxrsDXDgclMwyoxObqENF91oIYWWKSDa?=
 =?us-ascii?q?6VKbnSvkKN5u01OOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvs1a3?=
 =?us-ascii?q?meNH7thMoRVH0GuwMWUuPnkhuBXCRVanL0WLgztQs2EIa3MYCWfo2xjabJ4y?=
 =?us-ascii?q?C9EdUCfm1aB0qTFnHnd4aEQP0HQC2XK85l1DcDUO7yZZUm0ESWuRP30fJYKe?=
 =?us-ascii?q?zbsnkAuI7uzsdy4eL7lQo4/np/CMHb02LbHDI8pX8BWzJjhfM3mkd60FrWiv?=
 =?us-ascii?q?Agjg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HrAgDuzhpelyMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYFoBAEBAQELAQEBGggBgSWBTVIgEpNQgU0?=
 =?us-ascii?q?fg0OLY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQE?=
 =?us-ascii?q?BAQEFBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAE?=
 =?us-ascii?q?OAVODBIJLAQEzhUiYJwGNBA0NAoUdgkgECoEJgRojgTYBjBgagUE/gSMhgis?=
 =?us-ascii?q?IAYIBgn8BEgFsgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkU?=
 =?us-ascii?q?PgQmIA4ROgX2jN1d0AYEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2HrAgDuzhpelyMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYFoBAEBAQELAQEBGggBgSWBTVIgEpNQgU0fg0OLY4EAgx4Vh?=
 =?us-ascii?q?gcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABA?=
 =?us-ascii?q?QEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEzh?=
 =?us-ascii?q?UiYJwGNBA0NAoUdgkgECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsg?=
 =?us-ascii?q?kiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN?=
 =?us-ascii?q?1d0AYEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="323257044"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 08:51:29 +0100
Received: (qmail 24501 invoked from network); 12 Jan 2020 05:00:21 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-rdma@vger.kernel.org>; 12 Jan 2020 05:00:21 -0000
Date:   Sun, 12 Jan 2020 06:00:20 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-rdma@vger.kernel.org
Message-ID: <7663848.460819.1578805221563.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

