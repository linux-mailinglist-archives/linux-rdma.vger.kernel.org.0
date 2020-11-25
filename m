Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21982C3F0D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 12:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKYLZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 06:25:05 -0500
Received: from vie01a-dmta-pe05-2.mx.upcmail.net ([84.116.36.12]:55313 "EHLO
        vie01a-dmta-pe05-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728864AbgKYLZF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 06:25:05 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.92)
        (envelope-from <matthias.leopold@meduniwien.ac.at>)
        id 1khsv1-0003f3-Kb
        for linux-rdma@vger.kernel.org; Wed, 25 Nov 2020 12:25:03 +0100
Received: from [192.168.0.108] ([213.47.20.147])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id hsv1kHaQNVVAxhsv1kFV2x; Wed, 25 Nov 2020 12:25:03 +0100
X-Env-Mailfrom: matthias.leopold@meduniwien.ac.at
X-Env-Rcptto: linux-rdma@vger.kernel.org
X-SourceIP: 213.47.20.147
X-CNFS-Analysis: v=2.3 cv=LOsYv6e9 c=1 sm=1 tr=0
 a=JpRxMuvZrRLl2G7g9WOtgg==:117 a=JpRxMuvZrRLl2G7g9WOtgg==:17
 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10 a=20KFwNOVAAAA:8 a=bZH8oU2pz0In-QGGkksA:9
 a=QEXdDO2ut3YA:10
To:     linux-rdma@vger.kernel.org
From:   Matthias Leopold <matthias.leopold@meduniwien.ac.at>
Subject: Newbie Soft-RoCE Problem in VM
Message-ID: <f6d57d8f-f1c3-9de3-e0b2-3e670702290f@meduniwien.ac.at>
Date:   Wed, 25 Nov 2020 12:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPyXUFdb/wrR1E/yaFtstrXCx9Xja96zOT9ROakyHDq9ULQROSmsX6Fhq72O3ejr4GoFDberDISdEBhT6+FG1L8YsUgfFH2SgiKTtl1EFKAirG8CwhLu
 r0k0cxySLMqHP/oKNb/B63543+Fr0NVXf1gaiuubn7u+c/oI5Lt5pvUzJKSFcrJRzYQTgxFkZ0Nztp8BqPwb0N3F4IJLWLQlQSA=
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please excuse for posting to this list, but I couldn't get help at other 
places.

I'm trying to follow 
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_soft-_roce 
with two CentOS 7 KVM VMs and VirtIO NICs (running on CentOS 7 
hypervisors).
When verifying connectivity with ibv_rc_pingpong the server side fails with

Failed to modify QP to RTR
Couldn't connect to remote QP

The same happens with CentOS 8 guests running on CentOS 8 hypervisors.
Is Soft-RoCE _supposed_ to work in VMs?

thanks for help
Matthias
