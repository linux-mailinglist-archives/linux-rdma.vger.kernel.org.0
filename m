Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69394698816
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 23:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBOWs2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 17:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBOWs1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 17:48:27 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F6D442F9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 14:47:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id y11-20020a05683009cb00b0068dbf908574so99925ott.8
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mGyzDhqlmNkzqfDizj82mHik3/q2JNGX+vmu9LD/u4=;
        b=CVvIsnQ7ZgK0ZkITZa9k4vsmz8X0WAPL8Uk5VsG1fhEd9uHMFy0SstLmiqjNCbI2xk
         V1NTgVgQc1iEsyWdswsZ6TPEs+fIkGWAuo9NxrmFTrduBczPPkoomjhisXXm2oOsFSfP
         HzG/+4HXt1Hih/DTzW1AFxhWUJqV8GzWwSHczoAp957zYG5cwyaIltTtIu41+qa+gFOv
         8R5IVVFjpCu6FST9aK7hmRRmgrC/ShjLuvspconLPQG/6fGHEWvtJlg7Qxals6ZVgSmB
         SpnK/2MT7oXKgC42X58JFVoZxoj8iX+V3dxOGI2c51Gl4ekuJZv2xuAB7RESt1nW78dC
         s4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mGyzDhqlmNkzqfDizj82mHik3/q2JNGX+vmu9LD/u4=;
        b=GkDgtk5yKFd8k9qJCnxMgbQIwTYjqNJImukDXu9XUfu7loMqJ2+pSM9V3YEI0YlIDZ
         WYWs4jnKjibpzKwIbONJehwmikrWBZUzkjfihXjt+Z1is9Qk+bcgsmaJqnWKidlszqCh
         CibO1bNiNT4xtqMvXs00zw7lYqh6Qr7IiJwvzdqiPW9FOcjwfPh5y3lYOqx/zRZ83a1G
         sHQGCnHqw5+O7qSlDZLmVh7sLr9WF49TDOuWRXvE3UQzy2HVB1L9kCRQiMkcmMX+QHFZ
         FcNF9ltfACrksnufbg4QLXywCBmbkvGAVpqLUicCS4GY8/ccPZ7Qz0cqfZKRwr1B/Xld
         bQvg==
X-Gm-Message-State: AO0yUKWGGMlMDhxZm1JccGS2Fa+Lxyr3ble6RQw2grzIbU3250guUPDh
        la3Xo9nquE9Y9DfGjY2sbgxHFAFzBPs=
X-Google-Smtp-Source: AK7set/psOp/b3QAlch82cxuA0YF8gH9k1fZ+9sRCfSETFZMLiApeU+Vmdh0cG4P7i0PoLtHeB88IQ==
X-Received: by 2002:a05:6830:22fc:b0:68b:c93b:3f90 with SMTP id t28-20020a05683022fc00b0068bc93b3f90mr1681410otc.30.1676501256912;
        Wed, 15 Feb 2023 14:47:36 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id w1-20020a056830110100b0068d752f1870sm4862otq.5.2023.02.15.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:47:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/1] RDMA-rxe: Allow retry sends for rdma read responses
Date:   Wed, 15 Feb 2023 16:44:19 -0600
Message-Id: <20230215224419.9195-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the rxe driver is able to generate packets faster than the
IP code can process them it will start dropping packets and
ip_local_out() will return NET_XMIT_DROP. The requester side of
the driver detects this and retries the packet. The responder
does not and the requester recovers by taking a retry timer delay
and resubmitting the read operation from the last received packet.
This can and does occur for large RDMA read responses for multi-MB
reads. This causes a steep drop off in performance.

This patch modifies read_reply() in rxe_resp.c to retry the
send if err == -EAGAIN. When IP does drop a packet it requires
more time to recover than a simple retry takes so a subroutine
read_retry_delay() is added that dynamically estimates the time
required for this recovery and inserts a delay before the retry.

With this patch applied the performance of large reads is very
stable. For example with a 1Gb/sec (112.5 GB/sec) Ethernet link
between two systems, without this patch ib_read_bw shows the
following performance.

                    RDMA_Read BW Test
 Dual-port       : OFF		Device         : rxe0
 Number of qps   : 1		Transport type : IB
 Connection type : RC		Using SRQ      : OFF
 PCIe relax order: ON
 ibv_wr* API     : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 1024[B]
 Link type       : Ethernet
 GID index       : 2
 Outstand reads  : 128
 rdma_cm QPs	 : OFF
 Data ex. method : Ethernet
 <snip>
 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
 2          1000             0.56               0.56   		   0.294363
 4          1000             0.66               0.66   		   0.173862
 8          1000             1.32               1.20   		   0.157406
 16         1000             2.66               2.40   		   0.157357
 32         1000             5.54               5.46   		   0.179006
 64         1000             18.22              16.94  		   0.277533
 128        1000             21.61              20.91  		   0.171322
 256        1000             44.02              38.90  		   0.159316
 512        1000             70.39              64.86  		   0.132843
 1024       1000             106.50             100.49 		   0.102904
 2048       1000             106.46             105.29 		   0.053908
 4096       1000             107.85             107.85 		   0.027609
 8192       1000             109.09             109.09 		   0.013963
 16384      1000             110.17             110.17 		   0.007051
 32768      1000             110.27             110.27 		   0.003529
 65536      1000             110.33             110.33 		   0.001765
 131072     1000             110.35             110.35 		   0.000883
 262144     1000             110.36             110.36 		   0.000441
 524288     1000             110.37             110.36 		   0.000221
 1048576    1000             110.37             110.37 		   0.000110
 2097152    1000             24.19              24.10  		   0.000012
 4194304    1000             18.70              18.65  		   0.000005
 8388608    1000             18.09              17.82  		   0.000002

No NET_XMIT_DROP returns are seen up to 1MiB but at 2MiB and above they
are constant.

With the patch applied ib_read_bw shows the following
performance:

                    RDMA_Read BW Test
 Dual-port       : OFF		Device         : rxe0
 Number of qps   : 1		Transport type : IB
 Connection type : RC		Using SRQ      : OFF
 PCIe relax order: ON
 ibv_wr* API     : OFF
 TX depth        : 128
 CQ Moderation   : 100
 Mtu             : 1024[B]
 Link type       : Ethernet
 GID index       : 2
 Outstand reads  : 128
 rdma_cm QPs	 : OFF
 Data ex. method : Ethernet
 <snip>
 #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
 2          1000             0.34               0.33   		   0.175541
 4          1000             0.69               0.68   		   0.179279
 8          1000             2.02               1.75   		   0.229972
 16         1000             2.72               2.63   		   0.172632
 32         1000             5.42               4.94   		   0.161824
 64         1000             10.63              9.67   		   0.158487
 128        1000             31.06              28.11  		   0.230288
 256        1000             40.48              36.75  		   0.150543
 512        1000             70.00              66.00  		   0.135164
 1024       1000             94.43              89.26  		   0.091402
 2048       1000             106.38             104.34 		   0.053424
 4096       1000             109.48             109.16 		   0.027946
 8192       1000             108.96             108.96 		   0.013946
 16384      1000             110.18             110.18 		   0.007052
 32768      1000             110.28             110.28 		   0.003529
 65536      1000             110.33             110.33 		   0.001765
 131072     1000             110.35             110.35 		   0.000883
 262144     1000             110.36             110.35 		   0.000441
 524288     1000             110.35             110.31 		   0.000221
 1048576    1000             110.37             110.37 		   0.000110
 2097152    1000             110.37             110.37 		   0.000055
 4194304    1000             110.37             110.36 		   0.000028
 8388608    1000             110.37             110.37 		   0.000014

The delay algorithm computes approximately 50 usecs as the correct delay
to insert before retrying a read_reply() send.

Bob Pearson (1):
  RDMA-rxe: Allow retry sends for rdma read responses

 drivers/infiniband/sw/rxe/rxe_resp.c  | 62 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ++++
 2 files changed, 68 insertions(+), 3 deletions(-)


base-commit: 91d088a0304941b88c915cc800617ff4068cdd39
-- 
2.37.2

