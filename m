Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B281827032C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRRXo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 13:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRRXo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 13:23:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C203C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 10:23:44 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t76so7883667oif.7
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ihJzXb+hV3/6HRd9BgYNwInSJAlwIzVvA/7smO+1mes=;
        b=bDpdNPh4jM3zb3X0KCxBsr5pOycc/FvKxucfgRjmOVq4MxfQ7PM+SHjlT+MJykKquN
         SVeHGqQXtVGlvmQGPjXgQb6DqcWinFRFBpvGgnhD73Vbi1ImYKKvLQsw2dQAqTwclBfP
         w0AwFjrGDLp/IItm4UV6uDuKreB+Sipw/HgvEkXI9BB6IHi9ljPagr07hxDO7ej0Y/cf
         JhEymI4gp8BU+0i97D9ZFqWb8KnKikQOaOFZM6ldhOojAagD2bMuSu8MP4etE1oaiUER
         ZKBLpL18sshTo+QXzaNeFvzTAvmLzYHPS5pG5BzaH6Gqc8L+BX0QUK9TQ/sJMb00Jpz9
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ihJzXb+hV3/6HRd9BgYNwInSJAlwIzVvA/7smO+1mes=;
        b=rY3p0HgIb25FDkb0EbUxWpUuJYlO3hIniE9i4VHBduZd1Z4S/SmqAGOteK7ADRoAAW
         Ihw2Nnxcls5D3PYtTJwJYAbseutSc86MNoJysK4oA3MPoOVL6+TcX4WL9sZ4hM6qGUlq
         D1ClBSksGQJ8SoeIHdjvpRV+iqL57JsN1A/Gm4juOwhX7+1LTgwhczVvZzWVmMqa+Rpj
         4BcvBv1ZbDOS6dba9YbvmWlS4XgChl4x1s1L9Ong1oQ4nmtkWbZwDcgAqP7lqRfcBcAw
         izpa4CT96+l3XvbbgZN2WhLogREpeSV3LrmGgOwuuiwrVKKMYBwRITWTodQvX3+Nzs0Q
         doQw==
X-Gm-Message-State: AOAM533zU3Wo9WxR3OWfvZ5OzyyeFT03gof32wBVc5Bt8sE+iLq1nBZH
        hVAbiZbthSYy0gi3gkVXoHiMplBkmOI=
X-Google-Smtp-Source: ABdhPJxw4i1E7bEGSrsxZ6+KmogUsk8TK5v+NdXfAGLcLUbU9fRAX+wcmRsiKygH+OIHxx+CZKoPVg==
X-Received: by 2002:aca:55c5:: with SMTP id j188mr10237646oib.138.1600449823474;
        Fri, 18 Sep 2020 10:23:43 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:818d:d6c1:3b0:6a85? ([2605:6000:8b03:f000:818d:d6c1:3b0:6a85])
        by smtp.gmail.com with ESMTPSA id 91sm2758842ott.55.2020.09.18.10.23.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 10:23:43 -0700 (PDT)
To:     linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: pyverbs regression
Message-ID: <5c484f6d-364f-834d-0b16-144be92fc234@gmail.com>
Date:   Fri, 18 Sep 2020 12:23:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I pulled head of tree for rdma-core and the kernel and rebuilt them and I am now seeing the following warnings from pyverbs which I had not seen before. The tests I expected to run are still running but there seems to be an inconsistency somewhere.

<frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.srq.SRQ size changed, may indicate binary incompatibility. Expected 56 from C header, got 64 from PyObject
<frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.qp.QP size changed, may indicate binary incompatibility. Expected 104 from C header, got 112 from PyObject
<frozen importlib._bootstrap>:219: RuntimeWarning: pyverbs.qp.QPEx size changed, may indicate binary incompatibility. Expected 112 from C header, got 120 from PyObject

Bob Pearson
