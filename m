Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60078CE3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfG2Ncg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 29 Jul 2019 09:32:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:59023 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfG2Ncg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 09:32:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 06:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="162193708"
Received: from irsmsx105.ger.corp.intel.com ([163.33.3.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2019 06:32:35 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.59]) by
 irsmsx105.ger.corp.intel.com ([169.254.7.164]) with mapi id 14.03.0439.000;
 Mon, 29 Jul 2019 14:32:34 +0100
From:   "Jankowski, Robert" <robert.jankowski@intel.com>
To:     "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
CC:     "Jankowski, Robert" <robert.jankowski@intel.com>
Subject: RE: RDMA does not work with kernel 4.20 or 5.1
Thread-Topic: RDMA does not work with kernel 4.20 or 5.1
Thread-Index: AdVF/0cUzPfQHNCoSlWgqQO4q+ozsQAADpCgAASWzlA=
Date:   Mon, 29 Jul 2019 13:32:33 +0000
Message-ID: <05523083C296CF4BA19B0EC6154D20A776D78E14@IRSMSX102.ger.corp.intel.com>
References: <05523083C296CF4BA19B0EC6154D20A776D78CFC@IRSMSX102.ger.corp.intel.com>
 <05523083C296CF4BA19B0EC6154D20A776D78D25@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <05523083C296CF4BA19B0EC6154D20A776D78D25@IRSMSX102.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I have an issue with running RDMA server on kernel 4.20 or 5.1. Everything works on kernel 4.15 on the same host machine.
With libfabric members we found that there are low-level infiniband errors. Example ib_write_bw command returned:

$ /usr/bin/ib_write_bw -d mlx5_0
************************************
* Waiting for client to connect... *
************************************
Couldn't get device attributes
Unable to create QP.
Failed to create QP.
Couldn't create IB resources


Full thread you can read here: https://github.com/ofiwg/libfabric/issues/5149

Problem occurs with:
Linux distribution and version: Ubuntu 16.04 LTS
Linux kernel and version: Linux ubuntu 5.1.0 #1 SMP Wed May 15 08:00:39 CEST 2019 x86_64 x86_64 x86_64 GNU/Linux
InfiniBand hardware and firmware version: 
We are using Mellanox NICs ConnectX-4,
$ /usr/bin/ibv_devinfo
hca_id: mlx5_1
        transport:                      InfiniBand (0)
        fw_ver:                         14.20.1010
        node_guid:                      248a:0703:00b0:449f
        sys_image_guid:                 248a:0703:00b0:449e
        vendor_id:                      0x02c9
        vendor_part_id:                 4117
        hw_ver:                         0x0
        board_id:                       MT_2470111034
        phys_port_cnt:                  1
        Device ports:
                port:   1
                        state:                  PORT_DOWN (1)
                        max_mtu:                4096 (5)
                        active_mtu:             1024 (3)
                        sm_lid:                 0
                        port_lid:               0
                        port_lmc:               0x00
                        link_layer:             Ethernet

hca_id: mlx5_0
        transport:                      InfiniBand (0)
        fw_ver:                         14.20.1010
        node_guid:                      248a:0703:00b0:449e
        sys_image_guid:                 248a:0703:00b0:449e
        vendor_id:                      0x02c9
        vendor_part_id:                 4117
        hw_ver:                         0x0
        board_id:                       MT_2470111034
        phys_port_cnt:                  1
        Device ports:
                port:   1
                        state:                  PORT_ACTIVE (4)
                        max_mtu:                4096 (5)
                        active_mtu:             1024 (3)
                        sm_lid:                 0
                        port_lid:               0
                        port_lmc:               0x00
                        link_layer:             Ethernet


Can you help me find out what is wrong with my setup configuration?

Thanks,
Robert Jankowski
Intel Corporation
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

