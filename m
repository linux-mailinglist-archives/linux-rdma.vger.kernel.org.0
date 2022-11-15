Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E886299E3
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 14:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKONRm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiKONRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 08:17:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06028E3E
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 05:17:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o4so24096584wrq.6
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k+41jdhNVglPvhuVLep9moXbUuQWxFUaAGlXEnBiAo=;
        b=iQhGnOAnig524QlsspgHfbQvVnF8aGJ4i7YoBTpJkS1yuxW9XpY49luREyXMeokJA5
         Kh0GS/0l6oKzwtsDcHQsdCs0gKxQVoPxMct9RcxHg6R9+xyZWwk96JkMNM6/gLtop+fj
         8/6BP3tghdtO8Pvx6eaKACy1BtKeVCgPqA1svOvxp3RXU4/1mHiB+YqyP/heF2D+kHOe
         geaFcXaHIgLLPtCeLNhFkoUQJ/506N11MTPyf1qZhO7n7P2ooYuEGU4ZDroEU22hKY1A
         xduTOzXQ2VwUyDuOxZ14lc29ivjdeKOFln9F2/xLdU9DuWFuu64HtnYpN7zaWXk12H+m
         +J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k+41jdhNVglPvhuVLep9moXbUuQWxFUaAGlXEnBiAo=;
        b=ccO1zKzXw8ko9BODXXypvcXe/HjHslb1o0j9DqyUeH0/bs/taZINfLEF6Q9zIcP55P
         eB7Lf0JgnD7JecCrUibN6jRefTsMpTyIrrP1L3RfpOmu2sIHzooRdwHaMFop7gE5HUZe
         Tr+G2ISvUKLkNRislpQU+n/SX3AsHCtxMZAtw7VPimPopMaE+F82GZw5NK34ZQjIzuBI
         qXU/ntkBv/u70khUz3iEz5T1cPdnKPgWwPuRJ7q5c/+4R/664AiBhckXo1+Rz1GkUm6a
         LIsK52ya/zFgFFZIRwwx/W4+bylRmnkVTq64mB4nrtB3Wb0oaMYE0dKWogVI5nS7voCR
         K2eg==
X-Gm-Message-State: ANoB5pmuKUNf0ldK2F/ycT4GLpgStaPtcRGnICKcFHBSTgFB+R0yURI0
        bh/KAjQe0lMc6DO+CSBMqcbjIdxldgyyPw==
X-Google-Smtp-Source: AA0mqf57psjlDIhrdTC5K9QVW8qUBuh65Rpm37JFL/ke36HoTWntj5saCjs8EYhw4g8xop4XjOjAQw==
X-Received: by 2002:a5d:5242:0:b0:236:e271:c64e with SMTP id k2-20020a5d5242000000b00236e271c64emr10655055wrc.490.1668518257189;
        Tue, 15 Nov 2022 05:17:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003cfe6fd7c60sm2430572wmr.8.2022.11.15.05.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:17:36 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:17:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     faisal.latif@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] iwpm: crash fix for large connections test
Message-ID: <Y3ORbHXv5M8X8kqN@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ This isn't really the correct patch to blame.  Sorry! -dan ]

Hello Faisal Latif,

The patch dafb5587178a: "iwpm: crash fix for large connections test"
from Feb 26, 2016, leads to the following Smatch static checker
warning:

drivers/infiniband/core/iwpm_msg.c:437 iwpm_register_pid_cb() warn: 'nlmsg_request' was already freed.
drivers/infiniband/core/iwpm_msg.c:509 iwpm_add_mapping_cb() warn: 'nlmsg_request' was already freed.
drivers/infiniband/core/iwpm_msg.c:607 iwpm_add_and_query_mapping_cb() warn: 'nlmsg_request' was already freed.
drivers/infiniband/core/iwpm_msg.c:806 iwpm_mapping_error_cb() warn: 'nlmsg_request' was already freed.

drivers/infiniband/core/iwpm_msg.c
    385 int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_callback *cb)
    386 {
    387         struct iwpm_nlmsg_request *nlmsg_request = NULL;
    388         struct nlattr *nltb[IWPM_NLA_RREG_PID_MAX];
    389         struct iwpm_dev_data *pm_msg;
    390         char *dev_name, *iwpm_name;
    391         u32 msg_seq;
    392         u8 nl_client;
    393         u16 iwpm_version;
    394         const char *msg_type = "Register Pid response";
    395 
    396         if (iwpm_parse_nlmsg(cb, IWPM_NLA_RREG_PID_MAX,
    397                                 resp_reg_policy, nltb, msg_type))
    398                 return -EINVAL;
    399 
    400         msg_seq = nla_get_u32(nltb[IWPM_NLA_RREG_PID_SEQ]);
    401         nlmsg_request = iwpm_find_nlmsg_request(msg_seq);
    402         if (!nlmsg_request) {
    403                 pr_info("%s: Could not find a matching request (seq = %u)\n",
    404                                  __func__, msg_seq);
    405                 return -EINVAL;
    406         }
    407         pm_msg = nlmsg_request->req_buffer;
    408         nl_client = nlmsg_request->nl_client;
    409         dev_name = (char *)nla_data(nltb[IWPM_NLA_RREG_IBDEV_NAME]);
    410         iwpm_name = (char *)nla_data(nltb[IWPM_NLA_RREG_ULIB_NAME]);
    411         iwpm_version = nla_get_u16(nltb[IWPM_NLA_RREG_ULIB_VER]);
    412 
    413         /* check device name, ulib name and version */
    414         if (strcmp(pm_msg->dev_name, dev_name) ||
    415                         strcmp(iwpm_ulib_name, iwpm_name) ||
    416                         iwpm_version < IWPM_UABI_VERSION_MIN) {
    417 
    418                 pr_info("%s: Incorrect info (dev = %s name = %s version = %u)\n",
    419                                 __func__, dev_name, iwpm_name, iwpm_version);
    420                 nlmsg_request->err_code = IWPM_USER_LIB_INFO_ERR;
    421                 goto register_pid_response_exit;
    422         }
    423         iwpm_user_pid = cb->nlh->nlmsg_pid;
    424         iwpm_ulib_version = iwpm_version;
    425         if (iwpm_ulib_version < IWPM_UABI_VERSION)
    426                 pr_warn_once("%s: Down level iwpmd/pid %d.  Continuing...",
    427                         __func__, iwpm_user_pid);
    428         atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
    429         pr_debug("%s: iWarp Port Mapper (pid = %d) is available!\n",
    430                         __func__, iwpm_user_pid);
    431         iwpm_set_registration(nl_client, IWPM_REG_VALID);
    432 register_pid_response_exit:
    433         nlmsg_request->request_done = 1;
    434         /* always for found nlmsg_request */
    435         kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);

The iwpm_free_nlmsg_request() function will free "nlmsg_request"...
It's not clear what the "/* always for found nlmsg_request */" comment
means.  Maybe it means that the refcount won't drop to zero so the
free function won't be called?

    436         barrier();
--> 437         up(&nlmsg_request->sem);
                    ^^^^^^^^^^^^^
Dereference.

    438         return 0;
    439 }

regards,
dan carpenter
