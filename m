Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA55BB2A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 14:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGAMEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 08:04:02 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:42958 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfGAMEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jul 2019 08:04:01 -0400
Received: by mail-pg1-f173.google.com with SMTP id t132so2592251pgb.9
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jul 2019 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HgIPncYobqGNIvMdEM3blNbzxXOvLKdvFIiyRn4eKDU=;
        b=lX4roXfX3c8ET8wgWhtd24mRZ5ClNJlcP2KLxyeCZdWvIR4pq9Pkmm/mL8Lck9eWsX
         Bs+CXM/PDd5IBRy6H/TeE543+HuVpreQn6Lve6a4A5EyKpOeJ1QNjXDkbWIzeQLBovPx
         JRkdiBQnGJ2YLwY7943CCRr1S/MT0gHgeFb6l+N9/1Y3goybREyEU9AQHAiwzrcnEnZf
         +oAkspZkhgcDCvmLcF4gfZd4uvegD4aoSeMt8IAInmcpqsgj8SL+iNV9o7srYszaPq/1
         Ar5KVxMIt4vlJ0nPJdWSH/hFicEYPAGqEaSnP66IL25xaxjtS7qhgcQpx+8fpwxGcB/T
         gd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HgIPncYobqGNIvMdEM3blNbzxXOvLKdvFIiyRn4eKDU=;
        b=dSNaQUFgM/TiG03o66+nEHYfauF8I3nOnRmMLHl+5TMsxLmLJLG/f623kfaHRszXDJ
         USjkoUV0Y2QtPQUaP+uMscCTCV12Xml/XtwVBX5MEA+fQx1cKiXgL84J/lYnaytXLcww
         GqPySiWs6R5bhjNjR7nNr91O2aI4pmzi0u8efVaJPN++LtcyH0Fu8yHORhVB9vyrq0Ln
         HVtG/G2d3FysYY4emlAd3nB79XPd9XiebUrEG2EHtqt3Za3d13NEDSqTFit00RprhvZL
         FKHx9OV6W8R/Kj4EkzOv4MViWoMNlBnDe8ZR80cIZUtiOJZvvShHbIbFdskdkKisj0Aa
         zoLg==
X-Gm-Message-State: APjAAAV671QMLLNlqlpMY8Z7vANX0E/4wKqaoBaYQ3JTTwAyPOBRwKQw
        ZFHPfPZkoyeVtcsfAUk7wKA=
X-Google-Smtp-Source: APXvYqxEuHLijdlZk00n6wV5Y4FUZdw2/xaW4DFcw5IMmcEtLrmAXHdaXsopv87eoAwn9CQNVyOJpw==
X-Received: by 2002:a63:b555:: with SMTP id u21mr2529121pgo.222.1561982641058;
        Mon, 01 Jul 2019 05:04:01 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.239.6])
        by smtp.gmail.com with ESMTPSA id i36sm10887851pgl.70.2019.07.01.05.03.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:04:00 -0700 (PDT)
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Subject: RDMA on Mellanox ConnectX-4 Lx cannot work
Message-ID: <13dde97d-77a7-7663-1766-068082342e05@gmail.com>
Date:   Mon, 1 Jul 2019 20:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi RDMA guys

This is my first time to try to setup a rdma environment.
Would anyone please give some comment here and many thanks in advance.

I have nodes with a Mellanox CX4121A card as following

01:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
01:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]

It could work well with normal tcp/ip on it. But the rdma doesn't.
The mlx5_ib module is loaded, but /sys/class/infiniband is empty
[root@node91 eth2]# lsmod | grep mlx5
mlx5_ib               123666  0 
ib_core                98787  15 rdma_cm,ib_cm,ib_sa,iw_cm,xprtrdma,mlx5_ib,ib_mad,ib_srp,ib_ucm,ib_iser,ib_srpt,ib_umad,ib_uverbs,ib_ipoib,ib_isert
mlx5_core             160250  1 mlx5_ib

And here is the ouput of mstconfig.

There is _no_ LINK_TYPE_P1, does it mean this is a Ethernet-only card or I just miss some configuration ?

Device #1:
----------

Device type:    ConnectX4LX     
Name:           N/A             
Description:    N/A             
Device:         01:00.1         

Configurations:                              Next Boot
         MEMIC_BAR_SIZE                      0               
         MEMIC_SIZE_LIMIT                    _256KB(1)       
         ROCE_NEXT_PROTOCOL                  254             
         NON_PREFETCHABLE_PF_BAR             False(0)        
         NUM_OF_VFS                          8               
         SRIOV_EN                            True(1)         
         PF_LOG_BAR_SIZE                     5               
         VF_LOG_BAR_SIZE                     0               
         NUM_PF_MSIX                         63              
         NUM_VF_MSIX                         11              
         INT_LOG_MAX_PAYLOAD_SIZE            AUTOMATIC(0)    
         SW_RECOVERY_ON_ERRORS               False(0)        
         RESET_WITH_HOST_ON_ERRORS           False(0)        
         CQE_COMPRESSION                     BALANCED(0)     
         IP_OVER_VXLAN_EN                    False(0)        
         LRO_LOG_TIMEOUT0                    6               
         LRO_LOG_TIMEOUT1                    7               
         LRO_LOG_TIMEOUT2                    8               
         LRO_LOG_TIMEOUT3                    13              
         LOG_DCR_HASH_TABLE_SIZE             14              
         DCR_LIFO_SIZE                       16384           
         ROCE_CC_PRIO_MASK_P1                255             
         ROCE_CC_ALGORITHM_P1                ECN(0)          
         ROCE_CC_PRIO_MASK_P2                255             
         ROCE_CC_ALGORITHM_P2                ECN(0)          
         CLAMP_TGT_RATE_AFTER_TIME_INC_P1    True(1)         
         CLAMP_TGT_RATE_P1                   False(0)        
         RPG_TIME_RESET_P1                   300             
         RPG_BYTE_RESET_P1                   32767           
         RPG_THRESHOLD_P1                    1               
         RPG_MAX_RATE_P1                     0               
         RPG_AI_RATE_P1                      5               
         RPG_HAI_RATE_P1                     50              
         RPG_GD_P1                           11              
         RPG_MIN_DEC_FAC_P1                  50              
         RPG_MIN_RATE_P1                     1               
         RATE_TO_SET_ON_FIRST_CNP_P1         0               
         DCE_TCP_G_P1                        1019            
         DCE_TCP_RTT_P1                      1               
         RATE_REDUCE_MONITOR_PERIOD_P1       4               
         INITIAL_ALPHA_VALUE_P1              1023            
         MIN_TIME_BETWEEN_CNPS_P1            0               
         CNP_802P_PRIO_P1                    6               
         CNP_DSCP_P1                         48              
         CLAMP_TGT_RATE_AFTER_TIME_INC_P2    True(1)         
         CLAMP_TGT_RATE_P2                   False(0)        
         RPG_TIME_RESET_P2                   300             
         RPG_BYTE_RESET_P2                   32767           
         RPG_THRESHOLD_P2                    1               
         RPG_MAX_RATE_P2                     0               
         RPG_AI_RATE_P2                      5               
         RPG_HAI_RATE_P2                     50              
         RPG_GD_P2                           11              
         RPG_MIN_DEC_FAC_P2                  50              
         RPG_MIN_RATE_P2                     1               
         RATE_TO_SET_ON_FIRST_CNP_P2         0               
         DCE_TCP_G_P2                        1019            
         DCE_TCP_RTT_P2                      1               
         RATE_REDUCE_MONITOR_PERIOD_P2       4               
         INITIAL_ALPHA_VALUE_P2              1023            
         MIN_TIME_BETWEEN_CNPS_P2            0               
         CNP_802P_PRIO_P2                    6               
         CNP_DSCP_P2                         48              
         LLDP_NB_DCBX_P1                     False(0)        
         LLDP_NB_RX_MODE_P1                  OFF(0)          
         LLDP_NB_TX_MODE_P1                  OFF(0)          
         LLDP_NB_DCBX_P2                     False(0)        
         LLDP_NB_RX_MODE_P2                  OFF(0)          
         LLDP_NB_TX_MODE_P2                  OFF(0)          
         DCBX_IEEE_P1                        True(1)         
         DCBX_CEE_P1                         True(1)         
         DCBX_WILLING_P1                     True(1)         
         DCBX_IEEE_P2                        True(1)         
         DCBX_CEE_P2                         True(1)         
         DCBX_WILLING_P2                     True(1)         
         KEEP_ETH_LINK_UP_P1                 True(1)         
         KEEP_IB_LINK_UP_P1                  False(0)        
         KEEP_LINK_UP_ON_BOOT_P1             False(0)        
         KEEP_LINK_UP_ON_STANDBY_P1          False(0)        
         KEEP_ETH_LINK_UP_P2                 True(1)         
         KEEP_IB_LINK_UP_P2                  False(0)        
         KEEP_LINK_UP_ON_BOOT_P2             False(0)        
         KEEP_LINK_UP_ON_STANDBY_P2          False(0)        
         NUM_OF_VL_P1                        _4_VLs(3)       
         NUM_OF_TC_P1                        _8_TCs(0)       
         NUM_OF_PFC_P1                       8               
         NUM_OF_VL_P2                        _4_VLs(3)       
         NUM_OF_TC_P2                        _8_TCs(0)       
         NUM_OF_PFC_P2                       8               
         DUP_MAC_ACTION_P1                   LAST_CFG(0)     
         SRIOV_IB_ROUTING_MODE_P1            True(1)         
         IB_ROUTING_MODE_P1                  LID(1)          
         DUP_MAC_ACTION_P2                   LAST_CFG(0)     
         SRIOV_IB_ROUTING_MODE_P2            True(1)         
         IB_ROUTING_MODE_P2                  LID(1)          
         PCI_WR_ORDERING                     per_mkey(0)     
         MULTI_PORT_VHCA_EN                  False(0)        
         PORT_OWNER                          True(1)         
         ALLOW_RD_COUNTERS                   True(1)         
         RENEG_ON_CHANGE                     True(1)         
         TRACER_ENABLE                       True(1)         
         IP_VER                              IPv4(0)         
         UEFI_HII_EN                         False(0)        
         BOOT_VLAN                           1               
         LEGACY_BOOT_PROTOCOL                PXE(1)          
         BOOT_RETRY_CNT                      NONE(0)         
         BOOT_LACP_DIS                       True(1)         
         BOOT_VLAN_EN                        False(0)        
         BOOT_PKEY                           0               
         BOOT_DBG_LOG                        False(0)        
         UEFI_LOGS                           DISABLED(0)     
         EXP_ROM_UEFI_ARM_ENABLE             False(0)        
         EXP_ROM_UEFI_x86_ENABLE             False(0)        
         EXP_ROM_PXE_ENABLE                  True(1)         
         ADVANCED_PCI_SETTINGS               False(0)   


Linux node91 3.10.0-327.el7.centos.scst72.x86_64 #1 SMP Thu Jan 10 09:33:22 CST 2019 x86_64 x86_64 x86_64 GNU/Linux



