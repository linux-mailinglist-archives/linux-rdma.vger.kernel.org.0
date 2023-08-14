Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333477B8C1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjHNMhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 08:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHNMgm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 08:36:42 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EAE4A
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 05:36:41 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3174ca258bbso1005983f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 05:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016600; x=1692621400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woHvc1xTB7A+dr5sdjwiP8KrsmBxZuGEyG/Nj2eh1p8=;
        b=SLEsDnNpwDAvp0aL7m92tn8EcZVzy1+plHmEeMdvvVNsZoPbAivbXEvzxQq75A++zV
         p9lYrFlDtbVBc6+Od1E3LiN4R24dg/NENCNwazuKQNS+JhPJU6SOe5yOQ9RefTpxxoW2
         rVxaEgQ6aOPhSzBk5GfuN73ipZME1zCJHSmE83sp05f+exkBHlEZnwE5lHoaveGLmL5m
         nCQIBoElRWJS70O3DJWXDTgJjePigJQi8rsUraalWyoqIA4HfRkvtYoukHdfbrqjFfUn
         OkKwpuhmjKlNNoAkSAHQeqRBFWv9Jdsw37Ppb9Of7bzof7F96797Zs7vrEyZ+1BWFLap
         IOWw==
X-Gm-Message-State: AOJu0YxyDm0KAgzGQK8OgJ0HnfM4Jij3v1BrkwntBMNQPtUWGiiR46WU
        hLFRgL4XsjRcytZp0KoDzzJyM3iDSmE=
X-Google-Smtp-Source: AGHT+IHaX8ego8v1NPp8JoIGh2psTGG1mYJbEYPAncUXgE8Ighgg0MG5JMgj8h7m/OrEWmcE7DBq3g==
X-Received: by 2002:a5d:6142:0:b0:317:8fd:f01a with SMTP id y2-20020a5d6142000000b0031708fdf01amr6069786wrt.7.1692016600309;
        Mon, 14 Aug 2023 05:36:40 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0031416362e23sm14266333wrm.3.2023.08.14.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:36:39 -0700 (PDT)
Message-ID: <94a8b56d-0f9e-b75b-78d7-753122dcb3b0@grimberg.me>
Date:   Mon, 14 Aug 2023 15:36:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: isert patch leaving resources behind
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
 <91d94243-3741-0098-cd3c-a6ebc8f21cf2@grimberg.me>
 <d24e75327e6a4bfea3a9cf195f233253@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d24e75327e6a4bfea3a9cf195f233253@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/14/23 14:20, Saravanan Vajravel wrote:
> Hi Sagi,
> 
> In surprise removal case as well, isert_free_conn() should get invoked by
> iSCSI target module. Right? I am trying to understand how the kernel object
> leak is possible.  In your proposed patch, isert_conn is released in
> isert_wait_conn() handler. Again, isert module tries to release the
> connection in isert_free_conn() handler as well. Hence it will lead
> use-after-free issue.
> 
> Following are the snippet of iSCSI functions where iscsit_wait_conn()  and
> iscsit_free_conn() handlers are invoked in files iscsi_target_login.c &
> iscsi_target.c. We need to review if there is a possibility that
> iscsit_free_conn() is not invoked in any case. If yes, we may have to fix
> that.
> 
> void  iscsi_target_login_sess_out
> {
> .
> .
> .
> 	if (conn->conn_transport->iscsit_wait_conn)
> 		conn->conn_transport->iscsit_wait_conn(conn);
> 
> 	if (conn->conn_transport->iscsit_free_conn)
> 		conn->conn_transport->iscsit_free_conn(conn);
> .
> }
> 
> int iscsit_close_connection(
> 	struct iscsit_conn *conn)
> {
> .
> .
> .
> 	if (conn->conn_transport->iscsit_wait_conn)
> 		conn->conn_transport->iscsit_wait_conn(conn);
> .
> .
> .
> 	if (conn->conn_transport->iscsit_free_conn)
> 		conn->conn_transport->iscsit_free_conn(conn);
> .
> .
> }
> 
> @Leon,
> 
> I don't have the kernel logs in hand now. We can reproduce the issue and
> share.

You should look at the DEVICE_REMOVAL cm handler, it should call
iscsit_cause_connection_reinstatement. I do think that it needs to
pass it sleep=true (for device removal) so that it will wait for
conn_wait_comp...
