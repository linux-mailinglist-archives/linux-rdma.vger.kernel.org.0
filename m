Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052D77A455
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 02:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHMAUc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Aug 2023 20:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAUb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Aug 2023 20:20:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDEE5C
        for <linux-rdma@vger.kernel.org>; Sat, 12 Aug 2023 17:20:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so4063677a12.1
        for <linux-rdma@vger.kernel.org>; Sat, 12 Aug 2023 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691886032; x=1692490832;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dih0gup7iNgZuaHxcaBnqVn/hfE0FCMj0io4ecujZpU=;
        b=OSw8f5iMFcGjSJ55EzNrs1DAQ5/UvhWmaNeqYzYWvRxCB47A+DRGJ8XUDt51pG7TwO
         PNEkNqzqxIPuIwWiXWhl212cjqnpSkCMxrMPM/ls++3spqaGDYmlM8OCBcDtp9qKL1fY
         JEiMAGjBQLfg+ky5FIMYEZkqZB/jipR5tH0JrbogLEPGXeWYototgyiECzqyrFhwl88U
         d/fKs7hGB+Q8OXFQZyjbgkuZ/wxuW/DhHd9uAFTKllyNd06bVrnX7s+aW3MAHfyLwY2L
         N0xxpClon24EEzCtikkqMEhY/vtiYrPQWPAwAWcLxACBt8U/G2QwNKGS7LATIzGGJBjG
         MAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691886032; x=1692490832;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dih0gup7iNgZuaHxcaBnqVn/hfE0FCMj0io4ecujZpU=;
        b=ddb7zD3/64pNkvyFGjmCK1duXweDe/62yShjIauM21n3Rw7eQusVJXsRw3v2IF3kqW
         1NxN/ZfmO3IYstSoWvhuQFc/isTCBnGrIptTyJGj6DveSr/+bHG1azlKwbKF1Ychy1Vm
         5h6Wuoqtc+kPgevwrJjhnMkSy0w3YjhoYZlVXtTQoMWbNbzTrx5fx2xsOTInsFUlcYFO
         ytEIKaBq+nMi821rJW7+0xisToGJu28nN/YyHL32VGUDKgtKfNfuY8cxUoTEwe2P4T6B
         XLoTK6hJJm3kg2pOMM/Rx/UY4UrbKNElgWnVG7Nb2Qu6XVAcYk+EnI0+cFlomnsXqXAJ
         8Lsg==
X-Gm-Message-State: AOJu0YxW51UxuInXOfhP8oVsAsE+3YRrL4u1aCdER1vkDtZEZWYeyzHA
        iTJ19fHW7aZGjedfJj2hsUpLZNICOgU8gIKpUj5vUN9s2TI=
X-Google-Smtp-Source: AGHT+IFb86l9q6loSDzp4K0LJK7r/tVrIDR0VLv1U5d+4rO7GxQLhZNxo7LOAWuikeCEJOZGew2cS1L2eHz4Sijte4w=
X-Received: by 2002:aa7:c79a:0:b0:523:3e77:7eb5 with SMTP id
 n26-20020aa7c79a000000b005233e777eb5mr4181867eds.2.1691886031963; Sat, 12 Aug
 2023 17:20:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Shane St. Savage" <shanestsavage@gmail.com>
Date:   Sat, 12 Aug 2023 17:20:20 -0700
Message-ID: <CAPm9=-oCwCn5ZHogzStc4Lyo3=DOMwVDp=8b=jja1u484dEF=Q@mail.gmail.com>
Subject: infiniband-diags can't be installed in Fedora CoreOS due to perl dependency
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Just wanted to report that infiniband-diags cannot currently be
installed in Fedora CoreOS because the perl dependency is explicitly
forbidden.

https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170

This is a bit unfortunate because it also prevents usage of all the
non-perl utilities (ibstat, etc) included in infiniband-diags.

Would it make sense to split the perl utilities to a separate package
infiniband-diags-perl so that the C and shell utilities in
infiniband-diags can be installed without the perl dependency?

Thank you,
Shane St Savage
