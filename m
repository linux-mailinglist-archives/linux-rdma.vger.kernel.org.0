Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50427FD384
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2019 04:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKOD5p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 22:57:45 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46543 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKOD5p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 22:57:45 -0500
Received: by mail-pl1-f178.google.com with SMTP id l4so3706972plt.13
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 19:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ryussi-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=+K2ll8VHrzw8g7HSAa+mTDd2lbmDbwQQkL7WgmTkqMA=;
        b=JciRtdm/8Luv52rfYFzsfBZKeFsubbUFGg/8AawKh4E1igwOcoDGHcaMEZHrqk2brh
         /si3o9Hg3fw1JHYxGPTB89D8QE3PJbUu7ts8Bi0117JFOJrcGrTll0EA6j/TqmiRspaA
         cK+lvm+McTRIkVzNDvqysan3K8NKmgrUF5ulGt9G4iyU1ItuB1wccX3vDhq6wDfdxhv5
         9jrgtPC65ICT/jLmHSzkeo7aESSRuOn1pHPmwDDZ6O48Dw1UIPjBCvXeVsMua1LtA7a8
         z2ggXrBcaKwl7WCm15Q3cFLvlApdzJ9eS1iTFtH3bzJxBbFTe7fqKWLNRg9BtpZlaYps
         dgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=+K2ll8VHrzw8g7HSAa+mTDd2lbmDbwQQkL7WgmTkqMA=;
        b=FRy+lcEEh0PkhXsAplXNXLrU75iVVMy5Z0yiinN8B1jSYwe2QL1rTX5rX6SrI4WC+w
         UmCgVhp+vC/RexwJl/HcTS9/j7KnBmKXOLQFp0C0RGfviKeH4N79hq7UnDsN1qxz0eAJ
         KbqUd3MgRTtlI7ikOiJV8D8NMZJCbyHMD8o0HLXA4hvdSAEb+0kS+LGWKpoeM/A4qzzm
         /PrusxoCZarJaXNFhMQq2na9kgKCiVBmZTQencxQT3NgCscgYcz038yPV3ipeQu4ZNP0
         CKSjz074jEW4aPrynSX4Bg85fT0kbJlMRaV1VhHS/RHZibJwxOmTThWfd+7FXMIZGNy+
         xLUA==
X-Gm-Message-State: APjAAAVCjWN9z5Tf/ar8GxtqeW+KhgRYb8B/PrgjJ1VHsKCtLhYd2IkL
        z8nzgfR+DvqgwrqYI+3nnn6MIegbk08=
X-Google-Smtp-Source: APXvYqyv6obhucOhH2cZvKzuXjjiNGAVaFC9K7oDl2KHuBfoEeOqHDZ/ghLfFOyQYAn6n6I0zt4oBA==
X-Received: by 2002:a17:902:b482:: with SMTP id y2mr13352507plr.128.1573790264331;
        Thu, 14 Nov 2019 19:57:44 -0800 (PST)
Received: from [172.31.254.84] ([182.73.204.74])
        by smtp.gmail.com with ESMTPSA id k66sm4691730pgk.16.2019.11.14.19.57.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 19:57:43 -0800 (PST)
From:   Vinit Agnihotri <vinita@ryussi.com>
Subject: [question] ibv_reg_mr() returning EACCESS
To:     linux-rdma@vger.kernel.org
Message-ID: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
Date:   Fri, 15 Nov 2019 09:27:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I am trying to use setfsgid()/setfssid() calls to ensure proper access 
check for linux users.

However if user is non-root then ibv_reg_mr() returns EACCESS. While I 
am sure I am calling ibv_reg_mr()

as root user, not sure why it still returns EACCESS.

While going through libibverbs sources I realize EACCESS might be 
returned by this call:

if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
         return errno;

Can anyone provide any insight into this behavior? Does calling these 
systems calls in threads can affect

entire process? I checked /dev/infiniband/* has appropriate privileges.


Thanks & Regards,

Vinit.

