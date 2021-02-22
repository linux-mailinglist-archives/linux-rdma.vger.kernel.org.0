Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD66321CA6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhBVQUK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 22 Feb 2021 11:20:10 -0500
Received: from thor.rz.uni-duesseldorf.de ([134.99.128.245]:8270 "EHLO
        thor.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230260AbhBVQUH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 11:20:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by thor.rz.uni-duesseldorf.de (Postfix) with ESMTP id BE8DC700B66B
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 17:19:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at rz.uni-duesseldorf.de
Received: from thor.rz.uni-duesseldorf.de ([127.0.0.1])
        by localhost (thor.rz.uni-duesseldorf.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0_hBbwdJIJqR for <linux-rdma@vger.kernel.org>;
        Mon, 22 Feb 2021 17:19:15 +0100 (CET)
Received: from [192.168.2.126] (aftr-37-201-225-45.unity-media.net [37.201.225.45])
        (Authenticated sender: krfil100@uni-duesseldorf.de)
        by thor.rz.uni-duesseldorf.de (Postfix) with ESMTPA id A7164700B66A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 17:19:15 +0100 (CET)
To:     linux-rdma <linux-rdma@vger.kernel.org>
From:   Filip Krakowski <krakowski@hhu.de>
Subject: ibv_rc_pingpong fails to create a completion queue
Message-ID: <0fe96275-9413-18a7-8ec0-d6b456dd1f26@hhu.de>
Date:   Mon, 22 Feb 2021 17:19:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

whenever I try to test a reliable connection using "ibv_rc_pingpong -d 
mlx5_0" to start the server side the test immediately stops with 
"Couldn't create CQ". Since I couldn't find a solution for this problem 
in one week I would like to ask if someone has encountered this error 
before or knows a way of troubleshooting it. Just to be sure I updated 
the controller to its latest firmware (16.29.2002) today, but the error 
remained the same.

System Information
====

     * CentOS Linux release 8.1.1911 (Core)
     * Linux 4.18.0-151.el8.x86_64
     * ConnectX-5 (MCX555A-ECA)


Installed Packages
====

     * rdma-core-32.0-4.el8.x86_64
     * libibverbs-32.0-4.el8.x86_64


Loaded Kernel Modules (lsmod | grep -E 'rdma|mlx')
====

     rpcrdma               274432  0
     sunrpc                454656  22 
rpcrdma,nfsv4,auth_rpcgss,lockd,nfsv3,rpcsec_gss_krb5,nfs_acl,nfs
     rdma_ucm               32768  0
     rdma_cm                69632  5 
rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
     iw_cm                  53248  1 rdma_cm
     ib_cm                  57344  3 rdma_cm,ib_ipoib,ib_srpt
     mlx5_ib               327680  0
     ib_uverbs             147456  3 i40iw,rdma_ucm,mlx5_ib
     ib_core               356352  14 
rdma_cm,ib_ipoib,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_umad,ib_isert,i40iw,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
     mlx5_core             798720  1 mlx5_ib
     mlxfw                  24576  1 mlx5_core



Infiniband Device Info (ibv_devinfo)
====

     hca_id:    i40iw0
         transport:            iWARP (1)
         fw_ver:                0.2
         node_guid:            3cec:ef0d:51c3:0000
         sys_image_guid:            3cec:ef0d:51c3:0000
         vendor_id:            0x8086
         vendor_part_id:            14290
         hw_ver:                0x0
         board_id:            I40IW Board ID
         phys_port_cnt:            1
             port:    1
                 state:            PORT_DOWN (1)
                 max_mtu:        4096 (5)
                 active_mtu:        1024 (3)
                 sm_lid:            0
                 port_lid:        1
                 port_lmc:        0x00
                 link_layer:        Ethernet

     hca_id:    i40iw1
         transport:            iWARP (1)
         fw_ver:                0.2
         node_guid:            3cec:ef0d:51c2:0000
         sys_image_guid:            3cec:ef0d:51c2:0000
         vendor_id:            0x8086
         vendor_part_id:            14290
         hw_ver:                0x0
         board_id:            I40IW Board ID
         phys_port_cnt:            1
             port:    1
                 state:            PORT_ACTIVE (4)
                 max_mtu:        4096 (5)
                 active_mtu:        1024 (3)
                 sm_lid:            0
                 port_lid:        1
                 port_lmc:        0x00
                 link_layer:        Ethernet

     hca_id:    mlx5_0
         transport:            InfiniBand (0)
         fw_ver:                16.29.2002
         node_guid:            0c42:a103:0054:74ca
         sys_image_guid:            0c42:a103:0054:74ca
         vendor_id:            0x02c9
         vendor_part_id:            4119
         hw_ver:                0x0
         board_id:            MT_0000000010
         phys_port_cnt:            1
             port:    1
                 state:            PORT_ACTIVE (4)
                 max_mtu:        4096 (5)
                 active_mtu:        4096 (5)
                 sm_lid:            8
                 port_lid:        196
                 port_lmc:        0x00
                 link_layer:        InfiniBand


Best regards
Filip
